$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$testFileNameWithoutExtension = [System.IO.Path]::GetFileNameWithoutExtension((Split-Path -Leaf $MyInvocation.MyCommand.Path))
$testFileName = $MyInvocation.MyCommand.Path
$fakeFunctionFilePath = "$here\Fakes\FakeFunctionFile.ps1"
. $fakeFunctionFilePath
. "$here\..\TestCommon.ps1"

Describe "Get-Logger" {
    Context "default behavior" {
        It "returns named logger of calling script" {
            Write-Host "calling script: $testFileNameWithoutExtension"
            $actualLogger = Get-Logger
            $actualLogger.Logger.Name | Should Be $testFileNameWithoutExtension
        }
    }

    Context "nested script dot-sourced" {
        It "returns named logger of calling script" {
            Write-Host "calling script: $testFileNameWithoutExtension"
            $expectedLogger = Get-Logger
            Write-Debug "attempting fake function call"
            $actualLogger = MyFakeFunctionGetLogger
            $actualLogger.Logger.Name | Should Be $testFileNameWithoutExtension
        }
    }

    Context "nested function" {
        It "returns named logger of calling script" {
            Write-Host "calling script: $testFileNameWithoutExtension"
            function nestedFunctionGetLogger
            {
                Write-Output (Get-Logger)
            }

            $actualLogger = nestedFunctionGetLogger
            $actualLogger.Logger.Name | Should Be $testFileNameWithoutExtension
        }
    }
}
