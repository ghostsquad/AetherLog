$here = Split-Path -Parent $MyInvocation.MyCommand.Path

. $here\FakeFunctionFile.ps1

Export-ModuleMember -Function *
