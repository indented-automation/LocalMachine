function Set-ComputerDescription {
    <#
    .SYNOPSIS
        Set a description for the computer.
    .DESCRIPTION
        Set a description for the computer in the registry.
    #>

    [CmdletBinding(SupportsShouldProcess)]
    [OutputType([String])]
    param (
        [Parameter(Mandatory, Position = 1, ValueFromPipeline)]
        [String]$Description
    )

    process {
        if ($pscmdlet.ShouldProcess('Removing computer description')) {
            $valueInfo = GetRegistryValueInfo
            $params = @{
                Type  = 'String'
                Value = $Description
                Force = $true
            }
            try {
                New-ItemProperty @valueInfo @params
            } catch {
                $pscmdlet.ThrowTerminatingError($_)
            }
        }
    }
}