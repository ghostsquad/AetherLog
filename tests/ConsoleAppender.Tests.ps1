$here = Split-Path -Parent $MyInvocation.MyCommand.Path
# here : /branch/tests/Poshbox.Test
. "$here\..\TestCommon.ps1"

Describe "AddConsoleAppender" {
    It "adds console appender to root logger on load of PoshBox" {
        $appenders = @([log4net.LogManager]::GetAllRepositories()[0].Root.Appenders)
        $appender = $appenders[0]
        $appenders.Count | Should Be 1
    }
}
