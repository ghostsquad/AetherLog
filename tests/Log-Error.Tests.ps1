$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$testFileName = $MyInvocation.MyCommand.Path
$testBasePath = "$here\LogTestBase.ps1"
. "$here\..\TestCommon.ps1"
. $testBasePath

Describe 'Log-Error' {
    $logger = Get-Logger
    $action = { Log-Error "test msg" }

    WithAddedFileAppender "Error" "test msg" $action $logger
}
