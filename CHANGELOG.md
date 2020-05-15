# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [2.1.0] - 2020-05-15

### Changed

- Bumped PSScriptAnalyzer to `1.18.3` (via [@alagoutte](https://github.com/alagoutte))

## [2.0.0] - 2019-08-28

### Changed

- Refactored to new GitHub Action syntax
- Renamed options to:
  - rootPath
  - settingsPath
  - repoToken
  - sendComment
  - failOnErrors
  - failOnWarnings
  - failOnInfos
- Allow failing the GitHub Action on PSSA error, warning, or informational issues

## [1.2.1] - 2019-01-15

### Fixed

- Action will now only attempt to post a PR comment if a valid comments URL is found in the action payload

## [1.2.0] - 2019-01-14

### Changed

- Reorganize project so it is compatible with GitHub Marketplace

## [1.1.0] - 2018-01-06

### Changed

- Call PowerShell entrypoint script directly instead of calling bash first.
- Allow disabling sending PSScriptAnalyzer results back to PR by setting the environment variable `PSSCRIPTANALYZER_SEND_COMMENT` to `false` or `0`.

## [1.0.1] - 2018-12-28

### Fixed

- Fix logic and only post a GitHub comment to the PR if issues were found.

## [1.0.0] - 2018-12-28

### Added

- Initial release using PSScriptAnalyzer version `1.17.1`
