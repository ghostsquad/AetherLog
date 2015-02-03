$here = Split-Path -Parent $MyInvocation.MyCommand.Path
# here : /branch/tests/Poshbox.Test
. "$here\..\TestCommon.ps1"

Describe "Add-FileLogAppender" {
    $logger = Get-Logger
    $logPath = (Convert-Path "TestDrive:\")

    Context "No parameters" {
        It "Adds file appender" {
            $appendersBefore = $logger.Logger.Appenders.Count
            Add-FileLogAppender -log $logger -logPath $logPath
            $logger.Logger.Appenders.Count | Should Be ($appendersBefore + 1)
        }
    }

    Context "can accept logger from pipeline input" {
        It "Adds file appender to logger" {
            $appendersBefore = $logger.Logger.Appenders.Count
            $logger | Add-FileLogAppender -logPath $logPath
            $logger.Logger.Appenders.Count | Should Be ($appendersBefore + 1)
        }
    }
}
