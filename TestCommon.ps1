$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest
$private:here = Split-Path $MyInvocation.MyCommand.Path -Parent
$private:modulePath = (Get-ChildItem -Path $here -Filter *.psd1)[0].FullName
if((Test-Path (Join-Path $here 'test.config.ps1'))) {
    . $here\test.config.ps1
}
Import-Module $private:modulePath -Force -DisableNameChecking