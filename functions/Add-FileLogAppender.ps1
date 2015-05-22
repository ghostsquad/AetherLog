function Add-FileLogAppender{
    [CmdletBinding()]
    param (
        [log4net.Core.Level]$logLevelThreshold = [log4net.Core.Level]::Info,
        [string]$logPattern = "%date{ISO8601} %-5level [%ndc] - %message%newline",
        [string]$logPath = (Join-Path $PSScriptRoot "logs"),
        [string]$logFile = ((Split-Path $MyInvocation.PSCommandPath -Leaf) `
                + ([DateTime]::UtcNow.ToString("s") -replace ":","-") + "Z.log"),
        [parameter(ValueFromPipeline=$true)]
        [log4net.ILog]$log
    )

    process {
        Write-Debug "logLevelThreshold: $($logLevelThreshold.ToString())"
        Write-Debug "logPattern: $logPattern"
        Write-Debug "logPath: $logPath"
        Write-Debug "logFile: $logFile"

        if($log -eq $null){
            $log = Get-Logger -callStackStart 2
        }

        $logger = $log.Logger

        $patternLayout = new-object log4net.Layout.PatternLayout($logPattern)
        $fullLogFile = (Join-Path $logPath $logFile)
        $fileAppender = New-Object log4net.Appender.FileAppender($patternLayout, $fullLogFile, $true)
        $fileAppender.Threshold = $logLevelThreshold
        $fileAppender.LockingModel = new-object log4net.Appender.FileAppender+MinimalLock
        $fileAppender.ActivateOptions()

        $logger.AddAppender($fileAppender)
    }
}
