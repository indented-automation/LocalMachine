# Development module
$content = [Ordered]@{
    enum    = 'Ensure'
    classes = 'ComputerDescription'
    private = @(
        'GetRegistryValueInfo'
        'TestComputerDescriptionValue'
    )
    public  = @(
        'Get-ComputerDescription'
        'Remove-ComputerDescription'
        'Set-ComputerDescription'
    )
}

foreach ($itemType in $content.Keys) {
    foreach ($item in $content[$itemType]) {
        . ('{0}\{1}\{2}.ps1' -f $psscriptroot, $itemType, $item)
    }
}