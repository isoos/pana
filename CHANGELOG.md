## 0.22.22

- Fix issue with analyzing packages nested inside git repositories on windows.
  https://github.com/dart-lang/pana/issues/1207 

## 0.22.21

- Preserve all `formatter` settings in `analysis_options.yaml` when doing `dart format`.

## 0.22.20

- Reduced minimum description length to 50 characters.
- Filter SDK package `flutter` from the outdated report.

## 0.22.19

- Extended recognized image extensions in URL resolver.
- Preserve  formatter:page-width when doing `dart format`.
- Lower score for packages with discontinued dependency.

## 0.22.18

- Make example's `README.md` priority over any dart file in the examples directory.
- Expose more precise repository verification status in `AnalysisResult`.
- Track URL issues with explicit acceptance state (404 status does not cause score deduction).
  Also display such URLs in `AnalysisResult`.

## 0.22.17

- Fixed lower dependency constraint for `cli_util`.
- Use `flutter pub global activate dartdoc` for Flutter packages.

## 0.22.16

- Fixed deprecated API use.
- Preparing to use with `dartdoc 8.3.0`.

## 0.22.15

- Detect support for Swift Package Manager for ios/macos plugins.
- Fixes issue with local analysis without git repository root.
- Accept `logger` in `PackageAnalyzer.inspectDir` method.

## 0.22.14
- Doesn't exist.

## 0.22.13

- Pass-through for `formatter/page_width` in `analysis_options.yaml`.
- Upgraded `lints` to `^5.0.0`

## 0.22.12

- Updated report text for `wasm` readiness.
- Updated paragraph separation in report sections.

## 0.22.11

- Expose `wasm` readiness analysis in the report (without any score).

## 0.22.10

- Remove `workspace` and `resolution` properties from pubspec before analyzing.

## 0.22.9

- Updated suggestion for packages depending on SDK `_macros`.
- Deprecated the `renderSimpleSectionSummary` method in public API.

## 0.22.8

- Updated dependency: `tar: ^2.0.0`.
- New text logging format.
- Migrating `Summary.licenseFile` and `Summary.licenses` to `AnalysisResult.licenses`.
- *Breaking change:* Removed `ToolEnvironment.panaCache` field (not intended for public API).

## 0.22.7

- Enable `macros` experiment pass-through in `analysis_options.yaml`.
- Verify `executables` in `pubspec.yaml` and check if the related files exist.
- Fixed `has:executable` check.

## 0.22.6

- New recognized example files in the `example/bin` directory.
- Add `has:executable` tag for packages with `bin/<executable>.dart` files.

## 0.22.5

- Updated text and link on downgrade analysis.

## 0.22.4

- Report and score `pub downgrade` + `dart analyze`.

## 0.22.3

- Do not emit package names in `allDependencies` with trivial syntax issues.
- Log `dartdoc` output.

## 0.22.2

- `dartdoc` processing is run as the last step of the generated report.
- Fix: missing custom SDK environment (config directory use) when invoking Flutter.

## 0.22.1

- Fix: unspecified `--dartdoc-version` will use the latest version in an isolated
  environment. To use the SDK's `dartdoc`, set the value to `sdk`.

## 0.22.0

- `ToolEnvironment`:
  - `.create()` takes `configHomeDir` to specify config the home
    directory used for the analysis (helps switching different analyzer SDKs).
  - `create()` takes `pubHostedUrl` as `PackageAnalyzer.create()` was removed.
- `InspectOptions`:
  - `totalTimeBudget` to allow the dynamic reduction of `dartdocTimeout`.
  - `resourcesOutputDir` to store the resources files (without the previous callback).
- `bin/pana.dart` accepts new CLI arguments:
  - `--dart-config-home` (hidden)
  - `--flutter-config-home` (hidden)
  - `--dartdoc-output` (hidden)
  - `--dartdoc-version`
  - `--dartdoc-timeout` (hidden)
  - `--resources-output` (hidden)
  - `--total-timeout` (hidden)

**BREAKING CHANGES**

- Renamed `runProc` -> `runConstrained`.
- Removed:
  - deprecated APIs
  - `InspectOptions.checkRemoteRepository` - repositories are verified by default
  - `PackageAnalyzer`:
    - `create()`
    - `inspectVersions()`
    - `storeResource` callback in `inspectPackage()`, use `InspectOptions.resourcesOutputDir` instead
  - `ProcessOutput.asBytes`
  - `Report.joinSection()`
  - `ToolEnvironment`:
    - `create()` method dropped `useGlobalDartdoc` flag, will use global dartdoc
      when `dartdocVersion` is specified, otherwise uses the Dart SDK's `dart doc`.
    - `create()` method dropped `dartSdkDir`, `flutterSdkDir`, and `environment`,
      using `SdkConfig` for each of the SDKs.
    - removed parameters from `dartdoc()`
    - `detectFlutterUse()`
    - `get dartSdkDir`
    - `get flutterSdkDir`
    - `get environment`
    - `getFlutterVersion()`
  - `analysisOptionsFiles`
  - `changelogFileNames`
  - `currentAnalysisOptionsFileName`
  - `dartdocFailedSection`
  - `documentationCoverageSection()`
  - `documentationSectionTitle`
  - `firstFileFromNames`
  - `licenseFileNames`
  - `pubspecParseError`
  - `readmeFileNames`
- `ToolException` has reference to the entire `PanaProcessResult`, instead of just the `stderr`.

## 0.21.45

- Fix: don't report hidden constructors as undocumented API symbols.

## 0.21.44

- Fix: `dart:ui_web` is now part of the SDK-detection library list.
- The use of `kind` in `pub-data.json` is deprecated, as it may contain
  different value on different `dartdoc` version. The field may be
  removed in a future version.

## 0.21.43

- Fix: limit number of documentation entries exported in `pub-data.json`.
- Fix: Add `dart:js_interop_unsafe` as a web library.
- Pre-compute missing documentation symbol before pruning the results.

## 0.21.42

- Fix: global `dartdoc` activation is forced to happen from `pub.dev`.

## 0.21.41

- Pana binary now runs `dartdoc` and generates report based on the coverage
  (the same that pub-dev is using). The `--no-dartdoc` command line argument
  skips this part of the analysis.
- **Breaking change**: running the global dartdoc has become the default (instead
  of the SDK's `dart doc`), because the latest SDK is behind the latest `dartdoc`
  version, and we want to control what is being used by the analysis.
- **Breaking change**: `ToolEnvironment.dartdoc` returns `PanaProcessResult`.

## 0.21.40

- Fix: empty `yaml` parsing.
- Upgraded `package:lints` to `3.0.0`.

## 0.21.39

- Removed file size checks. (If upload limits allow it, `pana` should not complain.)

## 0.21.38

- Added `dart:ui_web` as Flutter Web platform.
- Fix: static analysis is done only when the package resolution was successful.

## 0.21.37

- `--no-warning` is no longer needed, and has no effect.
- Fix: expose repository verification issues in report.
- Upgraded `package:tar` to `1.0.0`.
- Added `AnalysisResult.grantedPoints` and `AnalysisResult.maxPoints`.

## 0.21.36

- Always use `dart format` instead of `flutter format`.

## 0.21.35

- Merge Dart 3 compatibility report into static analysis.
- *Breaking change*: Remove future SDK flags.
- Upgrading to `package:analyzer 6.0.0`

## 0.21.34

- Export missing `PanaProcessResult`.
- Fix `package:lints` as main dependency.

## 0.21.33

- Do not block repository check when `pubspec.yaml` is in path that is not accepted.
- Upgraded to Dart 3.0.
- Resolve `package:lints/core.yaml` locally before loading from GitHub.
- `InspectOptions.analysisOptionsYaml` is now deprecated.
- Removed null-safety report (Dart 3 compatibility report is used by default).

**Breaking changes**:
- `PanaProcessResult` no longer implements `dart:io`'s `ProcessResult`.
- `DartdocResult` uses `PanaProcessResult` instead of `ProcessResult`.
- Deprecating `InspectOptions.futureSdkTag`, configuration no longer used.

## 0.21.32

- Check the latest 2.x release compatibility only for Dart 2.x packages.

## 0.21.31

- Dart 3 compatibility section label includes Flutter 3.10 when applicable.
- Code cleanup in `ToolEnvironment`.

## 0.21.30

- Fix `pub upgrade` to exclude example directory.

## 0.21.29

- New report section: Dart 3 compatibility.

## 0.21.28

- Nicer error message if trying to download non-existing version of package.
- Removed `--[no|suppress]-analytics` flags and using `CI=true` instead.
  *Breaking changes* in `ToolEnvironment.fake` (removal of commands). 

## 0.21.27

- Upgraded dependency: `package:markdown`.
- Add tag `topic:<topic>` for packages that have assigned topics.

## 0.21.26

- Upgrading CI for new SDKs and enabling `pubspec.yaml` for Dart 3.
- Future SDK check is running on a copy, and resolves dependencies first.

## 0.21.25

- Strict names in package layout checks.
- Use different user-agent for URL checks.
- Use `PANA_CACHE` local directory to cache some of the shared result context (URLs, repository).

## 0.21.24

- Fix: allow <4.0.0 for Dart 3 packages.
- Fix: limit highlighted code snippet sizes in the report.
- Analyze multiple versions of the same package with shared result context (URLs, repository).

## 0.21.23

- Fix: tar extraction issue with directory entries.
- Fix: revert the extra line in `<summary>` blocks.

## 0.21.22

- Set `FLUTTER_ROOT` environment variable when running `flutter` commands.
- Updated `Summary`: `createdAt` field + new fields in `change` method.
- Isolate `git` process from host config through environment variables.

## 0.21.21

- `PanaTags` fields provide a single place for most of the tags that a package can get.
- Experimental options to analyze and tag compatibility with a future SDK.
- Lenient repository/homepage URL switch for packages that have no repository verification enabled.

## 0.21.20

- Add tag `has:screenshot` for packages that have screenshots.
- Renamed tag: `has:errors` -> `has:error`.
- New platform tagging with separate SDK runtimes.

## 0.21.19

- Add tag `has:errors` when the package has severe issues that prevent further analysis.
- Null safety tagger does not check `dart:` libraries.
- Removed internal hostname check from the report and score.
- Fixed: platform tagging with dart:mirrors.
- Deprecated `AnalysisOptions.isInternal`.
- Detect `CONTRIBUTING.md` during repository verification and expose if URL check succeeds.
- **BREAKING CHANGES** on rarely used external API:
  - Removed `UrlProblemCodes.internal`.
  - Removed `UrlChecker.addInternalHosts`.
  - Removed named parameter from `UrlStatus.getProblemCode`.

## 0.21.18

- Upgraded `package:analyzer` dependency.
- Generate 190x190 thumbnails of screenshots.

## 0.21.17

- Verify `funding` URLs and store the working ones in `AnalysisResult.fundingUrls`.
- Increase screenshot size limit to 4 MB and allow up to 10 screenshots.

## 0.21.16

- Preprocess license texts for better match.
- Explain `HEAD` request for URL checks.
- Grant 10 points for using only OSI-approved licenses.
- Fix: don't resolve dependencies in example folder of flutter packages.
- Fix: handle `CheckedFromJsonException` during repository verification.

## 0.21.15

- Improved URL resolver.
- Always use English locale for git commands.
- Fix: Remove `pubspec_overrides.yaml` when running `pub upgrade` or `pub outdated`.

## 0.21.14

- Predefined platform assignments for binary-only packages.
- Fix: internal hostname check uses full-length match.
- (Experimental) Expose `RepositoryProvider` in the analysis result (`Repository.provider`).
- (Experimental) Merged `RepositoryUrl` into `Repository` with extended URL resolver.
- (Experimental) Refactored fields of `Repository`.

## 0.21.13

- Populate the pubspec's `repository` field.
- Fix: Use the stripped/augmented `pubspec.yaml` for `pub outdated`.
- (Experimental) `Summary.result` (`AnalysisResult`) field for normalized and verified references and derived values.
- Moved `Summary.repository` under `AnalysisResult`.
- Additional formatting checks in repository URL parsing.

## 0.21.12

- Expose repository verification failures in the report (and score).
- Fixed repository verification exceptions.

## 0.21.11

- Cache the currently fetched depth in `GitLocalRepository`.
- List files and check all `pubspec.yaml` during repository verification.
- Typed `stdout` and `stderr` in `PanaProcessResult`.
- Updated SPDX licenses.
- Emit `license:<license>` tag on all the detected licenses.
- Emit `license:osi-approved` and `license:fsf-libre`.

## 0.21.10

- Fix issue in the computation of `pubHostedUrl` in `computeOutdatedVersions`.

## 0.21.9

- New defaults for JSON: do not include `null` values, explicit `toJson()`.
- Experimental `git` repository verification.
- Multiple license detection exposed in `Summary.licenses`.

## 0.21.8

- `pana` binary changed exit code from -1 to 127 when score is not within threshold.
- Start emitting `license:<license>` tags.
- Start populating `Summary.repository`, optionally with `git` remote branch check.

## 0.21.7

- Fix build verify test and generated version.

## 0.21.6

- `package:analyzer` dependency upgraded to `^3.1.0`.
- Fix dart analysis. Code problems are now propagated to the pana report.
- Fix retry on version listing HTTP requests during `getVersionListing`.
- `RepositoryUrl` (private API) to detect repository patterns and resolve paths.

## 0.21.5

- Support for top-level platform tags in `pubspec.yaml`.

## 0.21.4

- `getRepositoryUrl` with custom `branch` parameter (defaults to `master`).
- NOTE: `LicenseFile.url` and `getRepositoryUrl` is deprecated, will be removed in a future release.
- Fix platform classification for Flutter plugins without Dart or asset files.

## 0.21.3

- Tag Flutter plugins with `is:plugin`.
- Fix thrown exception to use `TagException`.

## 0.21.2

- Consistent license evaluation order.
- Better handling of timeout or output exceeded.
- Better handling of analyzer/code parsing errors.
- Better handling of JSON parsing issues.

## 0.21.1+1

* Fix release.

## 0.21.1

* Use only `dart pub get` for outdated check.
* Trim output of failed outdated process.

## 0.21.0

* New license detection.
* Use `package:lints/core.yaml` as default `analysis_options.yaml` override.
* Upgraded `package:analyzer` to `^2.1.0` and updated deprecated code use.
* Updated tool environment to use `[ dart | flutter ] format` instead of `dartfmt`.
* Updated tool environment to use `flutter pub outdated` when package uses Flutter. 

## 0.20.1

* Fix issue with git root directory detection.

## 0.20.0

* Fix SDK version parsing issue (also reading `stdout` for newer SDKs).
* `Summary.urlProblems` lists the URLs that should be displayed differently on `pub.dev`.
* **BREAKING CHANGES**
  * `UrlStatus` is converted to a class with fields.
  * `UrlChecker` internal cache is removed (incl. `maxCacheSize`, `existsInCache`, `markExistsInCache`).
    Caching implementations should wrap the `UrlChecker.checkUrlExists` method.
  * Removed `deduplicate` parameter from `runProc` function.
  * `runProc` process is killed if the output is above 10 MiB (regardless of line count).

## 0.19.1

* Upgraded dependencies: `analyzer` and `json_serializable`.
* Report a reason when no platform is detected - still lacking more details.
* Terminate the timeouted processes with `sigkill`.
* The `deduplicate` parameter in `runProc` is no longer used and will be ignored.
* Updated cache handlers for `UrlChecker`.

## 0.19.0

* Fix null-safety classification issue with `dart-ext:` imports.
* **BREAKING CHANGES**
  * Removed methods from public API: 
    `detectLicenseInContent`, `detectLicenseInDir`, `detectLicenseInFile`,
    `getLicenseUrl`, `getSignals`, `getVersionListing`, `handleProcessErrors`,
    `imageExtensions`, `listFiles`, `listFocusDirs`, `nonAsciiRuneRatio`,
    `parseCodeProblem`, `prettyJson`, `retryProc`, `runProcSync` (deleted),
    `sortedJson`, `withTempDir`, `CodeProblem`, `PackageLocation` (deleted),
    `ToolEnvironment.activateGlobalDartdoc` (deleted).

## 0.18.2

* Fix the detection of Flutter SDK.

## 0.18.1

* Fix null safety operator bug.

## 0.18.0

* Limit the length of the source spans in the report.
* Removed package list of 2.10 null-safety experiments.
* Detect `git` monorepo root and copy everything from that root for local analysis.
* Update dependencies to latest.
* Migration to null-safety.
* **BREAKING CHANGES**
  * Deprecate the `SCREAMING_CAPS` versions of the `LicenseNames` constants. 
    Use the newly introduced `lowerCamelCase` versions instead.
  * Removed internal models from public API (`Outdated`, `OutdatedPackage`, `VersionDescriptor`).

## 0.17.1

* Use `dart analyze` instead of `dartanalyzer`.
* `bin/pana` copies package content to a separate directory.

## 0.17.0

* Relax symlink handling
* Use streaming download and extraction.
* Do not block analysis on too many lines from `dartanalyzer`.
* **BREAKING CHANGES**
  * Removed `extractTarGz` method.
  * `ToolEnvironment.runAnalyzer` accepts only a single directory parameter.

## 0.16.2

* Fix symlink calculation

## 0.16.1

* Fix tagging of asset-only packages.
* Use `package:tar` instead of `tar` process.
* Run `dartanalyzer` separately for each directory.

## 0.16.0

* Use `dart pub` instead of `pub`.
* Flutter SDK on CI + Flutter package in end2end test.
* Fix: fill minimum Dart SDK range if missing.
* Fix: use `line-length` option in report.
* New options for CI: `dart-sdk`, `exit-code-threshold`.
* **BREAKING CHANGES**
  * Internal to `pub.dev`: `dartdocFailedSection` signature changed to match recent update.
  * Removed `InspectOptions.analysisOptionsUri`. Use `analysisOptionsYaml` instead.
    When `analysisOptionsYaml` is not specified, `pana` will load defaults from GitHub.
  * Removed `InspectOptions.nullSafetySectionEnabledBeforeOptin`.

## 0.15.4

* Award points for fully null safety enabled packages.
* Upgraded CI to use `2.12.0` SDK.
* Enabled dependency constraints to include null-safe versions.
* More graceful behavior when the analyzer crashes.

## 0.15.3
* Ignore Flutter version constraint upper bounds.

## 0.15.2
* If unsupported versions of dependencies are newer than 30 days or depend on an
  unreleased sdk the dependencies section will be marked as passing instead of
  partial.
  
## 0.15.1+1
* Update version constant.

## 0.15.1

* Fix of platform detection for executable-only packages.
* Fix outdated dependencies check, to ignore outdated packages from
  `pub outdated` if they are allowed by the constraint, and hence, just mutually
  incompatible.

## 0.15.0+1

* Does not depend on package:tar.

## 0.15.0

* **BREAKING** Removed:
  * `createPkgResolution`
  * `Summary.pkgResolution`
  * `PkgResolution`
  * `PkgDependency`
  * `ConstraintTypes`
  * `DependencyTypes`
  * `VersionResolutionType`
  * `ToolEnvironment.listPackageDirsSync`
* **BREAKING** `ToolEnvironment.runProc` and `ToolEnvironment.runProcSync` now 
  take the executable as the first element of the argument list instead of as a 
  separate argument.
* If unsupported versions of dependencies are newer than 30 days or depend on an
  unreleased sdk the package will still be awarded points in the report.
* Better timeout message for dartdoc section
* Adjust `runProc` timeout/kill handler.

## 0.14.10

* `Summary.allDependencies` to store the name of direct-, dev- or transient dependencies.
  `Summary.pkgResolution` will be removed in a future release.
* Upgraded `package:analyzer` to `0.41.0`.
* Deprecated methods in `ToolEnvironment`

## 0.14.9

* Use library import graph to determine null safety.

## 0.14.8

* Tag packages with `is:null-safe` regardless whether the current SDK support.

## 0.14.7

* Improvements to null safety section.

## 0.14.6+1

* Fixed NPE on missing `ReportStatus` and do not backfill automatically.

## 0.14.6

* Added a report section about null safety.

## 0.14.5

* Upgraded `package:analyzer` and `package:markdown`.
* Removed overrides in `pubspec.yaml`.
* Fixed first version for null safety (#791).

## 0.14.4

* Fix: RangeError in certain reported issues.
* New field: `ReportSection.id`.

## 0.14.3

* Classify asset-only packages as multi-platform. 

## 0.14.2

* Fix: NPE when LICENSE file is not recognized.
* Runs `dartanalyzer` only once.

## 0.14.1

* Fix: NPE in license URL checks.

## 0.14.0

* Fix: SDK constraint check should use the tool-environment's SDK version.
* Re-added non-ASCII character checks.
* Fix: Malformed UTF-8 files caused markdown checks to fail.
* Fix: Apply InspectOptions.analysisOptionsUri on new scoring.

**BREAKING CHANGES:**

* `bin/pana.dart` CLI changes:
  * removed `--report` flag (it is always the default),
    added `--verbose` flag to display full JSON data
  * removed `--scores` flag (it is always-on by default)
  * removed `--verbosity` option (the output data is always the same)
* Removed:
  * `bin/bulk.dart`
  * `ComponentNames`
  * `DartFileSummary`
  * `DartPlatform`
  * `Health`
  * `Maintenance`
  * `PlatformNames`
  * `PlatformUse`
  * `Stats`
  * `Suggestion`
  * `Summary.dartFiles`
  * `Summary.health`
  * `Summary.licenses` (using only a single `Summary.licenseFile`)
  * `Summary.maintenance`
  * `Summary.platform`
  * `Summary.stats`
  * `Summary.suggestions`
  * `Verbosity`

## 0.13.16

* Clarified and fixed report summaries.
* Fix: `mailto` links are no longer classified as unsecure.
* Download URLs recognize `.git` when linking to a file.

## 0.13.15

* Fix: handle new `--version` output from latest Dart SDK.
* Various nit fixes to the generated report.

## 0.13.14

* Fixed required URL checks in pubspec validation.
* Fixed `pub outdated` execution - using specified package dir.
* Various nit fixes to the generated report.
* Fix for deciding the latest version when no version is given for a hosted
  package.

## 0.13.13

* Deferred source span loading (fixes out of memory issue).

## 0.13.12

* Updated the rendering templates of `Section.summary`.
* Fixed percent calculation in documentation report.

## 0.13.11+1

* Fixed string processing in untar error path.

## 0.13.11

* Implemented new scoring report.
* Improved unpacking of package archives.
* Better path handling on Windows.

## 0.13.10

* Trust plugins platform declaration when assigning tags.

## 0.13.9+1

* Fixed NPE in old Flutter plugin format detection.

## 0.13.9

* Adds a tag for null safety.
* Adds suggestions for why tags don't apply.
* Command line uses `--source=path` by default.
* Support platform tagging of old-style flutter plugin declarations.
* Give penalty for old-style flutter plugin declarations.

## 0.13.8

* Fix: NPE after `dartanalyzer` exits with a failure.

## 0.13.7

* Fix: handle new `--version` output from latest Dart SDK.

## 0.13.6

* Fix: detect Dart files on Windows
* Fix: unescape double-backslash from files reported by `dartanalyzer` on Windows.
* Fix: avoid crashing on "file://" imports.

## 0.13.5

* Fix: when there are no libraries matching `lib/*.dart`, other libraries
  outside of `lib/src/` will be recognized as top-level libraries.
* Use `repository` from `pubspec.yaml` to resolve license URLs.
* Example detection: `README.md` is de-prioritized, Dart files take precedence.

## 0.13.4

* `InspectOptions.analysisOptionsUri` to optionally control which `pedantic`
  version (or other package's) ruleset is used for analysis lints.

## 0.13.3

* Updated tag detection for packages without a primary library.
* Upgraded analyzer to `^0.39.0`.
* More `dart:*` libraries in tag detection: `cli`, `nativewrappers`, `html_common`.
* Limit overall style lint penalties on health score: 25%.

## 0.13.2

* Don't penalize packages on legacy platform detection results.

## 0.13.1+4

* Fix the version number of pana

## 0.13.1+3

* Allow import of platform:flutter on platform web when calculating tags.
* Fix the finding of primary library.

## 0.13.1+2

* More handling of degenerate cases when computing sdk, platform and runtime
  tags.

## 0.13.1+1

* Handle degenerate cases when computing sdk, platform and runtime tags.

## 0.13.1

* Compute sdk, platform and runtime tags.

## 0.13.0

* `UrlChecker` follows redirects (max. 10 redirects).
* Fix: pre-release versions are not considered when detecting outdated dependencies.

* Detect and report sdk tags ('sdk:flutter', 'sdk:dart').

## 0.12.21

* Upgraded dependencies: `analyzer` `0.38.2`.

## 0.12.20

* Updated suggestion for not supporting future stable SDKs.

* Upgrade dependencies: `analyzer` to `0.37`

* Support the latest `json_annotation`.

* Don't penalize outdated dependency when the package's constraint allows it,
  but a dependent package or SDK restricts it.

## 0.12.19

* Fix: penalize outdated package constraints only for direct dependencies.

## 0.12.18

* Penalize package constraints that does not support the latest published versions of their dependencies.

## 0.12.17

* Recognize `.markdown` and `.mdown` files.
* Recognize `COPYING` and `UNLICENSE` as license file names (or prefix).
* Accept any extension for license files.

## 0.12.16

* Fixed the use of `pedantic` rules following the new versioned pattern.

## 0.12.15

* Fix: delete local temporary `pedantic_analyis_options_[timestamp].g.yaml`.

* Upgrade dependencies: `analyzer` to `0.36`

## 0.12.14

* Penalty for too large readme, changelog or example.

* Penalty for too large `pubspec.yaml`.

* Display calculated health and maintenance scores when `pana` is called with `--scores`.

* Ask for example only for packages with public libraries.

* Deduplicate `dartanalyzer` output lines.

## 0.12.13+1

* Support the latest `package:analyzer`.

## 0.12.13

* Don't block platform classification on hints.

* Apply `pedantic` rules without referencing `package:pedantic` in the inspected package's `pubspec.yaml`.

* Warn about insecure (non-`https`) image URLs in markdown content (readme, changelog and example).

## 0.12.12

* Link to package layout conventions in example-related suggestions.

* Use `package:pedantic` as default package analysis ruleset.

* Linear penalties for description.

* Updated suggestion messages.

## 0.12.11

* Maintenance score penalty for:
  * non-https URLs
  * `git` dependencies
  * strict parsing errors of `pubspec.yaml`

## 0.12.10

* Support `--line-length` in command-line and in `InspectOptions` (pass-through to `dartfmt`).

* Fix `pub upgrade` parsing.

* Strict SDK constraint status:
  * `sdk: any` or `sdk:` is considered missing constraint
  * handling cases without upper bound (`sdk: >1.0.0` is rejected by Dart2 latest)

## 0.12.9

* Analysis options used in code health scoring updated:
  * removed stale options,
  * included latest Flutter-enabled lints,
  * included latest stagehand-enabled lints.

* Upgraded to `package:analyzer 0.34.1`, which fixed a NPE.

* Validating `repository` and `issue_tracker` URLs.

## 0.12.8

* Code cleanup.

* Reduce the amount of warning+ level log messages when tools fail.

* Handle package with bad `pubspec.yaml`.

## 0.12.7

* Reduce the amount of logging when `dartfmt` fails due to an issue in the package.

* Display Dart SDK warning if package doesn't allow the latest Dart 2.X version.

## 0.12.6

* Bulk processing and comparison.

* Penalty for description using too many non-ASCII characters.

* Use `--dry-run` on executing flutter format.

* Retry the external process on downloading and listing packages.

* Use Flutter's internal Dart SDK to run `dartanalyzer` on Flutter packages.

## 0.12.5

* Increase the severity of missing SDK constraint.

* Make `example/readme.md` the first-level example-file candidate.

* Scores values should be consistently in the `[0.0-1.0]` range.

## 0.12.4

* Documented how scoring works.

* Estimate health score penalties.

## 0.12.3

* Increased `dartfmt` timeout to 5 minutes.

* Store basic stats in the analysis summary.

* Detect `example/readme.md` (or similar pattern) as an alternative to single `.dart` example.

## 0.12.2

* Bugfix: pre-v1 release should be pre-v0.1 instead.

## 0.12.1

* Bugfix: packages without Dart files failed the health checks.

## 0.12.0

**Breaking changes:**

* Named parameters in the following constructors: `Summary`, `DartFileSummary`, `PkgDependency`, `CodeProblem`.

* Removed per-file and overall `Fitness`, using a top-level `Health` report instead.
  Follows the proposed changes that allow us to clearly communicate the scoring mechanism.

* Removed `Penalty` and using the simpler to understand `score` in place of it.

**Updates:**

* Use `flutter format` for Flutter packages.

* Support relative local path with `--source path`.

* Track tool failures and set health score to 0 if there is any.

## 0.11.8

* Support Dart 2 gold release.

* Remove `strong-mode: true` check and suggestion.

* Do not check existence of non-external URLs.

* API for external caching of URL existence checks.

## 0.11.7

* Suggestions for SDK constraint and Dart 2 compatibility.

## 0.11.6

* Updated report on `dartanalyzer` suggestions.

## 0.11.5

* Less verbose logging.

* Updated platform classification:
  * Library conflict rule is moved to the end of the evaluation.
  * Top file-related suggestions are directly exposed.
  * The bulk summary suggestion is more compact.

* Updated suggestion messages.

## 0.11.4

* Export libraries used by pub site.

* Update minimum SDK to `2.0.0-dev.42.0`
  * The SDK was effectively restricted to at least this version due to other
    dependencies.

* Better expose platform conflict reasons.

## 0.11.3

* Support changing part of the analysis result.

* Fix `dartdoc` timeout when using `pub global run`.

## 0.11.2

* `dartdoc` processing: do not exclude packages by default, as `dartdoc` `0.19` handles SDK links.

* expose `getAgeSuggestion` method for pub site

* Update `analyzer` dependency to `^0.32.0`.

## 0.11.1

* Upgrade CI to dev.54 and fix new deprecation warnings.

* Bugfix: do not initialize `dartdocSuccessful` with a value.

* Support `--flutter-sdk` in the `pana` binary.

## 0.11.0

**Breaking changes:**

* `DartSdk`, `FlutterSdk` and `PubEnvironment` is replaced with `ToolEnvironment`.

* `ToolEnvironment.runAnalyzer` returns the text output of the process.

* Consolidating options in `InspectOptions`, changing `PackageAnalyzer` APIs.

* Move all output-related data structure to `src/model.dart`:
  * `CodeProblem.parse` -> `parseCodeProblem`
  * `Maintenance.getMaintenanceScore` -> `getMaintenanceScore`
  * `PkgResolution.create` -> `createPkgResolution`

* Move all runtime/version info into `PanaRuntimeInfo` (and use it in `Summary`).

* Removed `Fitness.suggestions` (moved it to `DartFileSummary`)

Updates:

* Run `dartdoc` (optional) and report if it was not able to complete successfully.

* Added a top-level `models.dart` library exposing several of the data classes.

* Check `homepage` and `documentation` properties to point to an existing and external web page.

* `--verbose` command-line and `Verbosity` option to control the details in the analysis output.

## 0.10.6

* Enable Dart 2 Preview in analyzer options (including non-Flutter packages).

* Change platform classification of `dart:isolate`: no longer available on `web`.

* Treat `environment:` keys as dependent SDKs (e.g. `flutter`).

* Use `LibraryElement.hasExtUri` to detect `dart-ext:` imports.

* Detailed suggestion messages when package has conflicting platforms.

## 0.10.5

* Enable Dart 2 Preview in Flutter analyzer options.

## 0.10.4

* Fix CI test

* Flutter-specific suggestion messages for `dartfmt` and `dartanalyzer`.

## 0.10.3

* Fix end-to-end test (package dependency changed).

* Move pubspec stripping inside `PubEnvironment.runUpgrade` (`dartdoc` service will get it for free).

* Handle more repository URLs (e.g. `www.github.com`).

* Expose Flutter detection to clients, with better naming (`isFlutter` -> `usesFlutter`).

## 0.10.2

* Fix issue of not using the `PUB_CACHE` directory when it was set.

* Update `analyzer` to 0.31 and extends `quiver` version range.

* Fix issue where we were not passing the proper package directory variable.

* Expose all `dartanalyzer` and `dartfmt` problems as suggestions.

## 0.10.1

* Include component list in platform classification reasons.

* Do not report on unconstrained SDK dependencies.

* New platform component: `build`.

* Remove `dependency_overrides` from `pubspec.yaml`.

## 0.10.0

**BREAKING CHANGES**:

* Removed `DartPlatform.description` and `DartPlatform.descriptionAndReason`
  because we don't use them elsewhere and complicates the `PlatformNames`
  with `everywhere` and `undefined`.

* Removed `PlatformNames.everywhere` and `PlatformNames.undefined`, because
  we don't print these anywhere except in tests.

* Removed `PlatformNames.dartExtension`, because we use it only internally.

* Removed `DartPlatform.restrictedTo`, using the fields `components` and `uses` instead.

* Removed `PlatformNames.server` (and its platform detection), using a wider `other` platform instead.

## 0.9.1

* Use raw links for images in repository URLs.

* Move unconstrained version penalty from health score to maintenance.

* Move platform conflict penalty from health score to maintenance.

* Sort maintenance suggestions in decreasing importance.

## 0.9.0+1

* Fix NPE when dependency has no constraint (e.g. git repo).

## 0.9.0

* Only direct unconstrained dependencies decrease the health score.

* Removed superfluous `pubspec.lock` validation.

* Recommend descriptions between 60 and 180 characters.

* Detect another license format

* Pass-through values of `analyzer_options.yaml` errors like `uri_has_not_been_generated`.

## 0.8.2

* Unblock platform classification on a new class of errors.

* Better messages in platform classification.

## 0.8.1

* Use Flutter-recommended analysis options when analyzer Flutter packages.

* **BREAKING BEHAVIOR**: Don't use `PUB_HOSTED_URL` for package downloads,
  as it has not worked out in practice. Instead, we've added a `--hosted-url`
  command line argument.

## 0.8.0

* `PackageAnalyzer.inspectPackage` added a named argument
  `deleteTemporaryDirectory`. Setting this to `false` retains the
  directory and prints its location to the log. Useful for debugging.

* `Maintenance`
  * **BREAKING** `getMaintenanceScore` now takes an optional `age` parameter
    replacing the previously required `publishDate` parameter.

  * Changed the meaning of version fields:
    * `isExperimentalVersion` now means pre-V1.
    * `isPreReleaseVersion` now means there is a pre-release flag
      like `-beta`, `-alpha`, etc.

  * **BREAKING** maintenance-related `Suggestion` entries as moved to `Maintenance.suggestions`

* **BREAKING** `Suggestion.file` is now `String` instead of `dynamic`.

* Detect the new format of native extensions.

* Unblock platform classification on a new class of errors.

* Use `PUB_HOSTED_URL` for package downloads.

## 0.7.3+1

* Allow more versions of `package:args`.

## 0.7.3

* Added `pana` as an executable.
  Enables `pub global activate pana`.

* Improved license detection: commented license files are now recognized.

## 0.7.2

* Handle more critical exceptions and report them with more details.

* The `Suggestion.bug` constructor had a breaking change – a required argument
  was added, but this is not intended for invocation by end-users.

## 0.7.1

* Add `SuggestionLevel.bug` and use it to record fatal errors with the tool.

## 0.7.0+1

* Fixed issue where analyzer and/or formatter were run on directories with no
  Dart files.

## 0.7.0

* **Breaking changes**

  * `Summary.sdkVersion` is now a `Version` instead of `String`.

  * `new PackageAnalyzer(...)` now takes a `DartSdk` instance instead of
    a `String`.

* `static Future<PackageAnalyzer> create(...)` was added to `PackageAnalyzer`.

* Added `logger` optional argument to `PackageAnalyzer.inspectPackage`.

## 0.6.2

* Allow platform classification for a small class of analysis errors.

## 0.6.1

* Don't count the absence of an `analysis_options.yaml` file against a package.

## 0.6.0

* **Breaking changes**

  * Removed `ToolProblem` class.
  * Removed `Summary.toolProblems`, in favor of `Summary.suggestions`.

* Detect and store maintenance-related data in summary.

  * Scoring of tool problems moved from `Fitness` to `Maintenance`.

* Provide human-readable feedback and instructions on some of the issues
  we find during the analysis.

## 0.5.1

* Use a consistent 2 minute timeout for all processes.

* Classify platform as `nowhere` when part of analysis fails.

## 0.5.0

* **Breaking changes**

  * `License` renamed to `LicenseFile`
  * `Summary.license` -> `licenses`: we'll return multiple licenses
  * Removed `LicenseNames.missing`: empty List will indicate no license file

* Greatly expanded and improved license detection.

## 0.4.0

* **Breaking changes**

  * Renamed `AnalyzerIssue` -> `ToolProblem`
    * Renamed `Summary.issues` -> `toolProblems`
    * Renamed `AnalyzerIssue.scope` -> `tool`
    * Renamed `AnalyzerScopes` -> `ToolNames`

  * Renamed `AnalyzerOutput` -> `CodeProblem`
    * Renamed `Summary.analyzerItems` and `DartFileSummary.analyzerItems` -> `codeProblems`

  * Refactored `CodeProblem` (previously `AnalyzerOutput`):
    * Split up `type`, new fields: `severity`, `errorType`, `errorCode`
    * Renamed `error` to `description`

  * Refactored `Fitness`:
    * Renamed `total` -> `magnitude`
    * Removed `value`, using `shortcoming` instead (`value` = `magnitude - shortcoming;`)

  * Refactored `PubSummary`, renamed to `PkgResolution`
    * Moved `pubspec` -> `Summary`
    * Moved `pkgVersion` -> `Pubspec.version`
    * Moved `authors` -> `Pubspec.authors`
    * Merged `packageVersions` and `availableVersions` into `dependencies`
    * Renamed `Summary.pubSummary` -> `pkgResolution`

  * Refactored `platform`:
    * Renamed `PlatformFlags` -> `PlatformNames`
    * Removed most of the platform-related classes, using `DartPlatform` instead

## 0.3.0

* Removed `PlatformSummary.package` in favor of `PlatformSummary.pubspec` of
  (new) type `PubspecPlatform`.

* Renamed `KnownPlatforms` to `PlatformFlags`. Also:
  * Removed `mirrors`, `browser` and `standalone`.
  * Renamed `native` to `dartExtension`.

* `PlatformInfo`
  * Now store `dart:*` references directly in `uses`.
  * `worksInStandalone` renamed to `worksOnServer`.
  * Other `.worksIn*` renamed to `worksOn*`.
  * Added `String get description` which returns a simple `String` description
    of the supported platforms. Examples: `everywhere`, `flutter`,
    `server, web`, `conflict`.
  * Removed `angular` as a value in `uses`.

## 0.2.4

* Detect native extensions.

* Detect licenses.

## 0.2.3

* Lots of stability improvements.

* Improvements to error handling.

## 0.2.2

* Lots of cleanup to JSON output.

* Improved stability.

* Platform detection basics.

## 0.2.1

* Added support for `flutter` packages.

* Expanded analysis to include transitive dependencies.

* Added scoring library.

* Moved the repo to `dart-lang`.

## 0.2.0

* A lot of tweaks. Still under heavy development.

## 0.0.1

* Initial version.
