library pana.summary;

import 'analyzer_output.dart';

class Summary {
  final String packageName;
  final DateTime packageDownloadTime;
  final Map<String, dynamic> packageDetails;
  final PubSummary pubSummary;
  final List<AnalyzerOutput> results;

  Summary(this.packageName, this.packageDetails, this.packageDownloadTime,
      this.pubSummary, this.results);

  Set<String> get resultTypes =>
      results.fold(new Set<String>(), (Set theSet, AnalyzerOutput item) {
        theSet.add(item.type);
        return theSet;
      });

  int issuesForType(String type) =>
      results.where((AnalyzerOutput output) => output.type == type).length;

  Map<String, int> get issueSummary =>
      new Map.fromIterable(resultTypes, value: issuesForType);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'packageName': packageName,
        'packageDownloadTime': packageDownloadTime.toIso8601String(),
        'packageDetails': packageDetails,
        'pubSummary': pubSummary,
        'results': results
      };
}

class PubSummary {
  final int exitCode;
  final String stdout;
  final String stderr;

  PubSummary(this.exitCode, this.stdout, this.stderr);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'exitCode': exitCode,
        'stdout': stdout,
        'stderr': stderr
      };
}
