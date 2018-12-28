#!/bin/sh

set -eu

pwsh -f /run.ps1 $*

exit $?
