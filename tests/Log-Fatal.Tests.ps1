$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$testFileName = $MyInvocation.MyCommand.Path
$testBasePath = "$here\LogTestBase.ps1"
. "$here\..\TestCommon.ps1"
. $testBasePath

Describe 'Log-Fatal' {
    $logger = Get-Logger
    $action = { Log-Fatal "test msg" }

    WithAddedFileAppender "Fatal" "test msg" $action $logger
}
