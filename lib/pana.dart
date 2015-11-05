import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as p;

import 'src/analyzer_output.dart';
import 'src/io.dart';
import 'src/logging.dart';
import 'src/summary.dart';

export 'src/analyzer_output.dart';
export 'src/summary.dart';

Future<Summary> run(String packageName) async {
  log.info('Starting package "$packageName".');

  var tempDir = await Directory.systemTemp.createTemp('pana.$packageName.');

  try {
    var client = new IOClient();

    Map<String, dynamic> packageDetails;
    DateTime downloadDate;

    try {
      var info = await getPackageInfo(packageName, client);

      packageDetails = info['latest'];

      var version = packageDetails['version'];
      log.info('Version $version');

      var archiveUri = Uri.parse(packageDetails['archive_url']);

      downloadDate = await downloadAndExtract(tempDir.path, archiveUri, client);
    } finally {
      client.close();
    }

    List<AnalyzerOutput> items = const <AnalyzerOutput>[];

    log.info('Running pub upgrade');
    var result = await Process.run('pub', ['upgrade', '--verbosity', 'all'],
        workingDirectory: tempDir.path);

    var pubSummary =
        new PubSummary(result.exitCode, result.stdout, result.stderr);

    if (pubSummary.exitCode == 0) {
      log.info('Finished pub upgrade');
      log.info('Starting analysis');
      items = await analyze(tempDir.path, strong: true);
      log.info('Finished analysis');
    } else {
      log.severe('pub upgrade failed - exit code ${pubSummary.exitCode}');
      log.info(pubSummary.stderr);
    }

    return new Summary(packageName, packageDetails, downloadDate, pubSummary,
        new List<AnalyzerOutput>.unmodifiable(items));
  } finally {
    tempDir.deleteSync(recursive: true);
  }
}

Future<Map> getPackageInfo(String packageName, Client client) async {
  var pkgUri = 'https://pub.dartlang.org/api/packages/$packageName';
  log.info('Downloading $pkgUri');

  var response = await client.read(pkgUri);

  return JSON.decode(response);
}

Future<DateTime> downloadAndExtract(
    String tempDir, Uri archiveUri, Client client) async {
  log.info('Downloading $archiveUri');
  assert(archiveUri.toString().endsWith('.tar.gz'));

  var streamedResponse = await client.send(new Request('GET', archiveUri));

  if (streamedResponse.statusCode != 200) {
    // TODO: provide more info here
    throw new HttpException(
        "Failed with status code ${streamedResponse.statusCode}",
        uri: archiveUri);
  }

  log.info('Extracting to $tempDir');
  await extractTarGz(streamedResponse.stream, tempDir);
  log.info('Extracted to $tempDir');

  var dateHeader = streamedResponse.headers['date'];
  DateTime date;
  if (dateHeader != null) {
    date = parseHttpDate(dateHeader);
  }

  return date;
}

Future<List<AnalyzerOutput>> analyze(String projectDir, {bool strong}) async {
  // find all dart files in 'lib' directory
  projectDir = new Directory(projectDir).resolveSymbolicLinksSync();

  var libsRelativePaths =
      await getDartFilesInDir(projectDir, ['lib', 'bin']).toList();

  if (libsRelativePaths.isEmpty) {
    return const [];
  }

  var args = <String>['--format', 'machine'];

  if (strong == true) {
    args.add('--strong');
  }

  log.info('Analyzing libraries (${libsRelativePaths.length}):\n' +
      libsRelativePaths.join('\n'));

  args.addAll(libsRelativePaths);

  var process =
      await Process.start('dartanalyzer', args, workingDirectory: projectDir);

  var stdoutDrain = getLines(process.stdout).forEach((line) {
    log.warning('Analyzer stdout: $line');
  });

  var items = <AnalyzerOutput>[];
  var errorLines = <String>[];

  try {
    await for (var line in getLines(process.stderr)) {
      try {
        items.add(AnalyzerOutput.parse(line, projectDir: projectDir));
      } on ArgumentError catch (_) {
        errorLines.add(line);
      }
    }
  } finally {
    await stdoutDrain;
  }

  var code = await process.exitCode;

  if (code != 0 && code != 3) {
    var msg = new StringBuffer("Analyzer failed with exit code $code");

    if (errorLines.isNotEmpty) {
      msg.writeln();
      msg.writeAll(errorLines, '\n');
    }

    throw msg.toString();
  }

  if (errorLines.isEmpty) {
    log.warning(
        'Got some parse errors on these lines\n' + errorLines.join('\n'));
  }

  return items;
}

Stream<String> getDartFilesInDir(
    String projectDir, List<String> subDirs) async* {
  for (var dir in subDirs) {
    var libDir = new Directory(p.join(projectDir, dir));

    if (!libDir.existsSync()) {
      continue;
    }

    await for (var dartFile in await libDir
        .list(recursive: false, followLinks: false)
        .where((fse) =>
            fse is File && p.extension(fse.path.toLowerCase()) == '.dart')
        .map((fse) => p.relative(fse.path, from: projectDir))) {
      yield dartFile;
    }
  }
}
