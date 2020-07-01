[cmdletbinding()]
param()

$ErrorActionPreference = 'Stop'

$nl = [Environment]::NewLine

$analyzeParams = @{
    Recurse = $true
}

# By default, run PSScriptAnalyzer on the whole repository
# but allow overriding this with INPUT_ROOTPATH environment variable
if ($env:INPUT_ROOTPATH) {
    $analyzeParams.Path = Join-Path '/github/workspace' $env:INPUT_ROOTPATH
} else {
    $analyzeParams.Path = $env:GITHUB_WORKSPACE
}

# Path to custom script analzyer settings
if ($env:INPUT_SETTINGSPATH) {
    $analyzeParams.Settings = Join-Path '/github/workspace' $env:INPUT_SETTINGSPATH
}

# Run PSScriptAnalyzer
$issues   = Invoke-ScriptAnalyzer @analyzeParams
$errors   = $issues.Where({$_.Severity -eq 'Error'})
$warnings = $issues.Where({$_.Severity -eq 'Warning'})
$infos    = $issues.Where({$_.Severity -eq 'Information'})

# Create comment string
$comment  = '**PSScriptAnalyzer results:**'
$comment += '{0}<details><summary>Errors: [{1}], Warnings: [{2}], Information: [{3}]</summary><p>{4}{5}```' -f $nl, $errors.Count, $warnings.Count, $infos.Count, $nl, $nl
if ($errors.Count -gt 0) {
    $comment += $nl + ($errors | Format-List -Property RuleName, Severity, ScriptName, Line, Message | Out-String -Width 80).Trim()
}
if ($warnings.Count -gt 0) {
    $comment += $nl+ $nl + ($warnings | Format-List -Property RuleName, Severity, ScriptName, Line, Message | Out-String -Width 80).Trim()
}
if ($infos.Count -gt 0) {
    $comment += $nl + $nl + ($infos | Format-List -Property RuleName, Severity, ScriptName, Line, Message | Out-String -Width 80).Trim()
}
$comment += '{0}{1}```{2}</p></details>' -f $nl, $nl, $nl
Write-Output $comment

# Get comment URL
$ghEvent     = Get-Content -Path $env:GITHUB_EVENT_PATH | ConvertFrom-Json -Depth 30
$commentsUrl = $ghEvent.pull_request.comments_url

# Send comment back to PR if any issues were found
if ($commentsUrl -and ($env:INPUT_SENDCOMMENT -eq "$true" -or $env:INPUT_SENDCOMMENT -eq 1) -and $env:INPUT_REPOTOKEN -and ($errors.Count -gt 0 -or $warnings.Count -gt 0 -or $infos.Count -gt 0)) {
    $params = @{
        Uri = $commentsUrl
        Method = 'Post'
        Headers = @{
            Authorization = "token $env:INPUT_REPOTOKEN"
        }
        ContentType = 'application/json'
        Body = @{body = $comment} | ConvertTo-Json
    }
    Invoke-RestMethod @params > $null
}

$exitCode = 0
if ($env:INPUT_FAILONERRORS   -eq 'true' -or $env:INPUT_FAILONERRORS   -eq 1) { $exitCode += $errors.Count}
if ($env:INPUT_FAILONWARNINGS -eq 'true' -or $env:INPUT_FAILONWARNINGS -eq 1) { $exitCode += $warnings.Count}
if ($env:INPUT_FAILONINFOS    -eq 'true' -or $env:INPUT_FAILONINFOS    -eq 1) { $exitCode += $infos.Count}
exit $exitCode
