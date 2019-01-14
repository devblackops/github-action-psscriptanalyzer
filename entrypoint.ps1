#requires -modules PSScriptAnalyzer

[cmdletbinding()]
param()

$ErrorActionPreference = 'Stop'

$nl = [Environment]::NewLine

$analyzeParams = @{
    Recurse = $true
}

# By default, run PSScriptAnalyzer on the whole repository
# but allow overriding this with PSSCRIPTANALYZER_ROOT environment variable
if ($env:PSSCRIPTANALYZER_ROOT) {
    $analyzeParams.Path = $env:PSSCRIPTANALYZER_ROOT
} else {
    $analyzeParams.Path = $env:GITHUB_WORKSPACE
}

# Path to custom script analzyer settings
if ($env:PSSCRIPTANALYZER_SETTINGS_PATH) {
    $analyzeParams.Settings = $env:PSSCRIPTANALYZER_SETTINGS_PATH
}

# Run PSScriptAnalyzer
$issues   = Invoke-ScriptAnalyzer @analyzeParams
$errors   = ($issues.where({$_.Severity -eq 'Error'})).Count
$warnings = ($issues.where({$_.Severity -eq 'Warning'})).Count
$infos    = ($issues.where({$_.Severity -eq 'Information'})).Count

$strings = @{
    summary    = 'PSScriptAnalyzer results:{0}Errors: {1, 6}{2}Warnings: {3, 4}{4}Information: {5}'
    errorList  = '{0}The following PSScriptAnalyzer errors caused the check to fail:{1}'
    warningMsg = '{0} There were **[{1}]** warnings and **[{2}]** informational issues found. These did not cause the check to fail but it is recommended that they be fixed.'
}

# Create analysis summary
$summary = ($strings.summary -f $nl, $errors, $nl, $warnings, $nl, $infos)
$comment = '```' + $nl + $summary + $nl + '```'
if ($errors -gt 0) {
    $comment += $strings.errorList -f $nl, $nl
    $errorMsg = ($issues.Where({$_.Severity -eq 'Error'}) |
        Format-List -Property RuleName, Severity, ScriptName, Line, Message |
        Out-String -Width 80).Trim()
    $comment += '```' + $nl + $errorMsg + $nl + '```'
}
if (($warnings -gt 0) -or ($infos -gt 0)) {
    $comment += $strings.warningMsg -f $nl, $warnings, $infos
}
Write-Output $comment

# Comment threshold


# Send comment back to PR if any errors were found
if ($env:PSSCRIPTANALYZER_SEND_COMMENT -ne 'false' -and $env:PSSCRIPTANALYZER_SEND_COMMENT -ne 0) {
    if ($errors -gt 0) {
        $ghEvent = Get-Content -Path $env:GITHUB_EVENT_PATH | ConvertFrom-Json
        $params = @{
            Uri = $ghEvent.pull_request.'_links'.comments.href
            Method = 'Post'
            Headers = @{
                Authorization = "token $env:GITHUB_TOKEN"
            }
            ContentType = 'application/json'
            Body = @{body = $comment} | ConvertTo-Json
        }
        Invoke-RestMethod @params > $null
    }
}

exit $errors