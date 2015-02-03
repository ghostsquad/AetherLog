
<#############################################################################
GpLog makes Logging for PowerShell easy by leveraging Log4Net.
#############################################################################>

@{
      ModuleToProcess = 'GpLog.psm1'

        ModuleVersion = '0.1.0'

                 GUID = '01612AEC-6B5F-4D34-A183-5E9FEA8BC9A4'

               Author = 'Weston McNamee'

          CompanyName = 'GhostSquad'

            Copyright = 'Copyright 2014 Weston McNamee'

          Description = 'GpLog makes Logging for PowerShell easy by leveraging Log4Net.'

    PowerShellVersion = '3.0'

         NestedModules = @(
                        'GravityPS'
                        'PSCX'
                        )

      FunctionsToExport = @(
                        'Add-FileLogAppender'
                        'Get-Logger'
                        'Log-Debug'
                        'Log-Error'
                        'Log-Fatal'
                        'Log-Info'
                        'Log-Warning'
                        )

             FileList = @(
                        'LICENSE'
                        'README.md'
                        'GpLog.psd1'
                        'GpLog.psm1'
                        'log4net.dll'
                        'functions\AddConsoleLogAppender.ps1'
                        'functions\Add-FileLogAppender.ps1'
                        'functions\Get-Logger.ps1'
                        'functions\Log-Debug.ps1'
                        'functions\Log-Error.ps1'
                        'functions\Log-Fatal.ps1'
                        'functions\Log-Info.ps1'
                        'functions\Log-Warning.ps1'
                        )

          PrivateData = @{
                            PSData = @{
                                Tags = 'gravity logging log4net gplog'
                                LicenseUri = 'http://www.apache.org/licenses/'
                                ProjectUri = 'https://github.com/GhostSquad/GpLog'
                                IconUri = ''
                                ReleaseNotes = ''
                            }
                        }
}
