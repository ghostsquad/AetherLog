function Get-Logger {
    [cmdletbinding()]
    param(
        [string]$loggerName,
        [int]$callStackStart = 1
    )

    function TryGetLogger([log4net.ILog[]]$loggers, [string]$loggerName, [ref]$logger){
        foreach($ilog in $loggers){
            if($ilog.Logger.Name -eq $loggerName){
                $logger.Value = $ilog
                return $true
            }
        }
        return $false
    }

    function TryGetValidLoggerName {
        param(
            [System.Management.Automation.CallStackFrame]$callStackFrame,
            [ref]$loggerCandidateName
        )
        if([string]::IsNullOrWhiteSpace($callStackFrame.ScriptName)){
            Write-Debug "scriptname is empty!"
            return $false
        }
        $loggerCandidateName.Value = $([System.IO.Path]::GetFileNameWithoutExtension($callStackFrame.ScriptName))
        return $true
    }

    if(-not [string]::IsNullOrWhiteSpace($loggerName)){
        return [log4net.LogManager]::GetLogger($loggerName)
    }

    [log4net.ILog]$logger = $null
    $loggers = [log4net.LogManager]::GetCurrentLoggers()

    if($loggers.Count -gt 0){
        Write-Debug ("Current Loggers: " + $([string]::Join(", ", ($loggers | %{$_.Logger.Name}))))
    }
    else{
        Write-Debug "No loggers registered."
    }

    $callStack = @(Get-PSCallStack)

    if($loggers.count -gt 0){
        for($callStackFrameIndex = $callStackStart; $callStackFrameIndex -lt $callStack.Count; $callStackFrameIndex++){
            [string]$loggerCandidateName = $null
            $tryGetValidLoggerNameResult = TryGetValidLoggerName $callStack[$callStackFrameIndex] ([ref]$loggerCandidateName)
            if($tryGetValidLoggerNameResult){
                $tryGetLoggerResult = TryGetLogger $loggers $loggerCandidateName ([ref]$logger)
                if($tryGetLoggerResult){
                    Write-Debug "Found Logger: $loggerCandidateName"
                    return $logger
                }
            }
        }
    }

    [string]$loggerCandidateName = $null
    $result = TryGetValidLoggerName $callStack[$callStackStart] ([ref]$loggerCandidateName)
    if($result){
        Write-Debug "Using Logger: $loggerCandidateName"
        $logger = [log4net.LogManager]::GetLogger($loggerCandidateName)
    }
    else {
        Write-Debug "Can't find logger"
        Write-Debug ($callStack | select Command, Location, ScriptName, ScriptLineNumber, Position, FunctionName | fl -Force | Out-String)
        $logger = [log4net.LogManager]::GetLogger([Guid]::NewGuid().ToString())
    }

    return $logger
}
