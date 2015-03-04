param (
    [string]$TestName = "*",
    [switch]$Debug,
    [switch]$CurrentContext = $false,
    [switch]$Clean,
    [switch]$PassThru
)
$ErrorActionPreference = "Stop"
if($Debug){
    $global:DebugPreference = "Continue"
} else {
    $global:DebugPreference = "SilentlyContinue"
}

$here = (Split-Path -Parent $MyInvocation.MyCommand.Path)

if((Test-Path (Join-Path $here 'build.config.ps1'))) {
    Write-Host 'Running Build.Config.ps1'
    . $here\build.config.ps1 $Clean
}

if($currentContext) {
    Import-Module Pester
    Invoke-Pester -TestName $TestName -Path $here -PassThru:$PassThru
} else {
    if($Debug) {
        $debugPrefStr = '$global:DebugPreference = ''Continue'''
    } else {
        $debugPrefStr = [string]::Empty
    }
    $cmd = 'Set-Location ''{0}''; {1}; Import-Module Pester; Invoke-Pester -TestName ''{2}'' -EnableExit;' -f $here, $debugPrefStr, $TestName
    powershell.exe -noprofile -command $cmd
}