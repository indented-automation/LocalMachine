function Remove-ComputerDescription {
    <#
    .SYNOPSIS
        Remove an existing description for a computer.
    .DESCRIPTION
        Remove an existing description for a computer in the registry.
    .EXAMPLE
        Get-ComputerDescription

        Remove any existing computer description.
    #>

    [CmdletBinding(SupportsShouldProcess)]
    param ( )

    $valueInfo = GetRegistryValueInfo
    if ((TestComputerDescriptionValue) -and $pscmdlet.ShouldProcess('Removing computer description')) {
        Remove-ItemProperty @valueInfo
    }
}