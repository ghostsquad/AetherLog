$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$testFileName = $MyInvocation.MyCommand.Path
$testBasePath = "$here\LogTestBase.ps1"
. "$here\..\TestCommon.ps1"
. $testBasePath

Describe 'Log-Info' {
    $logger = Get-Logger
    $action = { Log-Info "test msg" }

    WithAddedFileAppender "Info" "test msg" $action $logger
}
