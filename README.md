# github-action-psscriptanalyzer

[![GitHub Actions Status][github-actions-badge]][github-actions-build]

[GitHub Action](https://github.com/features/actions) to run [PSScriptAnalyzer](https://github.com/PowerShell/PSScriptAnalyzer) static code analysis checks on PowerShell for [Pull Requests](https://help.github.com/articles/about-pull-requests/).

## Success Criteria

By default, this action will succeed if **zero** PSScriptAnalyzer **errors** and **warnings** are found.
Failing on errors, warnings, or informational issues can be configured. See [Usage](#Usage) below.
The sending of comments back to the PR if the action fails can be disabled if desired.

## Usage

### Basic

Basic configuration that will run PSSA and fail on errors or warnings, and send a comment back to the PR with a summary.
Note, that `repoToken` is required for sending comments back.

```yaml
name: CI
on: [pull_request]
jobs:
  lint:
    name: Run PSSA
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - name: lint
      uses: devblackops/github-action-psscriptanalyzer@master
      with:
        repoToken: ${{ secrets.GITHUB_TOKEN }}
```

### Advanced

Advanced configuration that will run PSSA only in the `MyModule` directory, with custom PSSA settings, and fail on errors, warnings, or informational issues.
A comment back to the PR with the PSSA summary will also be sent if any issues were detected.

```yaml
name: CI
on: [pull_request]
jobs:
  lint:
    name: Run PSSA
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - name: lint
      uses: devblackops/github-action-psscriptanalyzer@master
      with:
        rootPath: MyModule
        settingsPath: pssa_settings.psd1
        sendComment: true
        repoToken: ${{ secrets.GITHUB_TOKEN }}
        failOnErrors: true
        failOnWarnings: true
        failOnInfos: true
```

### Docker

Use the Docker Hub version of the Action instead of building the container during the check.

```yaml
name: CI
on: [pull_request]
jobs:
  lint:
    name: Run PSSA
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - name: lint
      uses: docker://devblackops/github-action-psscriptanalyzer:2.2.0
      with:
        repoToken: ${{ secrets.GITHUB_TOKEN }}
```

## Inputs

| Name | Default | Description |
|------|---------|-------------|
| rootPath       | \<none>  | The root directory to run PSScriptAnalyzer on. By default, this is the root of the repository.
| settingsPath   | \<none>  | The path to a PSScriptAnalyser settings file to control rules to execute.
| sendComment    | true  | Enable/disable sending comments with PSScriptAnalyzer results back to PR.
| repoToken      | \<none>  | GitHub token the action will use to send comments back to PR with. Use `${{ secrets.GITHUB_TOKEN }}`.
| failOnErrors   | true  | Enable/disable failing the action on PSScriptAnalyzer error items.
| failOnWarnings | true  | Enable/disable failing the action on PSScriptAnalyzer warning items.
| failOnInfos    | false | Enable/disable failing the action on PSScriptAnalyzer informational items.

## Example

![](media/example.png)

[github-actions-badge]: https://github.com/devblackops/github-action-psscriptanalyzer/workflows/CI/badge.svg
[github-actions-build]: https://github.com/devblackops/github-action-psscriptanalyzer/actions
