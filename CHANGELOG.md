# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [2.4.0] - 2021-10-22

### Changed

- [**#PR18**](https://github.com/devblackops/github-action-psscriptanalyzer/pull/18) - Updated pwsh, Ubuntu, and PSSA versions (via [@alagoutte](https://github.com/alagoutte))
  - pwsh `7.0.3` -> `7.1.5`
  - Ubuntu `18.04` -> `20.04`
  - PSSA `1.19.1` -> `1.20.0`

## [2.3.1] - 2021-02-27

### Fixed

- [**#PR15**](https://github.com/devblackops/github-action-psscriptanalyzer/pull/15) - Typo in code comment (via [@revolter](https://github.com/revolter))

## [2.3.0] - 2020-08-31

### Fixed

- [**#PR13**](https://github.com/devblackops/github-action-psscriptanalyzer/pull/13) - Remove `outputs` section from `action.yml` to resolve error when `outputs` is empty (via [@SleepySysadmin](https://github.com/SleepySysadmin))

### Changed

- Updated docker image to `powershell:7.0.3-ubuntu-18.04`.

- Updated `PSScriptAnalyzer` to `1.19.1`.

## [2.2.0] - 2020-06-30

### Fixed

- [**#PR8**](https://github.com/devblackops/github-action-psscriptanalyzer/pull/8) - Fix SendComment (Only if RepoToken is available) (via [@alagoutte](https://github.com/alagoutte))

### Changed

- [**#PR10**](https://github.com/devblackops/github-action-psscriptanalyzer/pull/10) - Update checkout action to v2 (`actions/checkout@v2`) (via [@alagoutte](https://github.com/alagoutte))

- [**#PR7**](https://github.com/devblackops/github-action-psscriptanalyzer/pull/7) - Updated PSScriptAnalyzer to `1.19.0` (via [@alagoutte](https://github.com/alagoutte))

- [**#PR6**](https://github.com/devblackops/github-action-psscriptanalyzer/pull/6) - Updated PowerShell Docker iamge to `7.0.1` (via [@alagoutte](https://github.com/alagoutte))

## [2.1.1] - 2020-05-15

### Fixed

- Fixed reference to warning environment variable (`INPUT_FAILONWARNINGS`) (via [@CrazyCodeUK](https://github.com/CrazyCodeUK))

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
