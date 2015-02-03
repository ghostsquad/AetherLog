$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$testFileName = $MyInvocation.MyCommand.Path
$testBasePath = "$here\LogTestBase.ps1"
. "$here\..\TestCommon.ps1"
. $testBasePath

Describe 'Log-Debug' {
    $action = { Log-Debug "test msg" }
    $logger = Get-Logger

    WithAddedFileAppender "Debug" "test msg" $action $logger
}
