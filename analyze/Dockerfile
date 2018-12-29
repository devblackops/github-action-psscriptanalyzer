FROM mcr.microsoft.com/powershell:6.1.0-ubuntu-18.04 as base
SHELL ["pwsh", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
RUN Set-PSRepository -Name PSGallery -InstallationPolicy Trusted; \
    Install-Module PSScriptAnalyzer -RequiredVersion 1.17.1 -Repository PSGallery

FROM base as analyzer
LABEL "com.github.actions.name"         = "PSScriptAnalyzer"
LABEL "com.github.actions.description"  = "Run PSScriptAnalyzer tests"
LABEL "com.github.actions.icon"         = "box"
LABEL "com.github.actions.color"        = "blue"

LABEL "name"       = "github-action-psscriptanalyzer"
LABEL "version"    = "1.0.1"
LABEL "repository" = "https://github.com/devblackops/github-action-psscriptanalyzer"
LABEL "homepage"   = "https://github.com/PowerShell/PSScriptAnalyzer"
LABEL "maintainer" = "Brandon Olin <brandon@devblackops.io>"

ADD entrypoint.sh  /entrypoint.sh
ADD run.ps1        /run.ps1

COPY LICENSE README.md /

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]