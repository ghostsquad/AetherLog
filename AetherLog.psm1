$ErrorActionPrefence = "Stop"
Set-StrictMode -Version Latest

$here = Split-Path -Parent $MyInvocation.MyCommand.Path

[Void](Add-Type -Path $here\log4net.dll)

. $here\functions\AddConsoleLogAppender.ps1
. $here\functions\Add-FileLogAppender.ps1
. $here\functions\Get-Logger.ps1
. $here\functions\Log-Debug.ps1
. $here\functions\Log-Error.ps1
. $here\functions\Log-Fatal.ps1
. $here\functions\Log-Info.ps1
. $here\functions\Log-Warning.ps1

[log4net.LogManager]::ResetConfiguration();

AddConsoleLogAppender

Export-ModuleMember -Function *-*