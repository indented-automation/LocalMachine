function TestComputerDescriptionValue {
    <#
    .SYNOPSIS
        Tests for the presence of the value which holds the computer description.
    .DESCRIPTION
        Tests whether or not the registry value describing the computer description is present.
    #>

    [CmdletBinding()]
    param ( )

    $valueInfo = GetRegistryValueInfo
    if (Test-Path -Path $valueInfo.Path) {
        $key = Get-Item -Path $valueInfo.Path

        return $key.GetValueNames() -contains $valueInfo.Name
    }
    return $false
}