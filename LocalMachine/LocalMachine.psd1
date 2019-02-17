@{
    RootModule = 'LocalMachine.psm1'
    ModuleVersion = '1.0.0'
    CompatiblePSEditions = @('Core', 'Desk')
    GUID = '0466c1a6-26d3-4dd6-b34f-365fad21b27a'
    Author = 'Chris Dent'
    CompanyName = 'Chris Dent'
    Copyright = '(c) 2019 Chris Dent. All rights reserved.'
    Description = 'An example module.'
    PowerShellVersion = '5.0'
    FunctionsToExport = 'Get-ComputerDescription', 'Remove-ComputerDescription', 'Set-ComputerDescription'
    DscResourcesToExport = 'ComputerDescription'
    PrivateData = @{
        PSData = @{
            LicenseUri = 'https://opensource.org/licenses/MIT'
            ProjectUri = 'https://github.com/indented-automation/LocalMachine'
        }
    }
}