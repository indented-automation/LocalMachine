Build-Module -Path (Resolve-Path -Path $PSScriptRoot\*\build.psd1)

$rootModule = Join-Path -Path $PSScriptRoot -ChildPath 'build\*\*\*.psm1' | Resolve-Path
$tokens = $errors = $null
$ast = [System.Management.Automation.Language.Parser]::ParseFile(
    $rootModule,
    [ref]$Tokens,
    [ref]$Errors
)
$dscResourcesToExport = $ast.FindAll(
    {
        param ( $node )

        $node -is [System.Management.Automation.Language.TypeDefinitionAst] -and
        $node.IsClass -and
        $node.Attributes.TypeName.FullName -contains 'DscResource'
    },
    $true
).Name

if ($dscResourcesToExport) {
    $moduleManifest = Join-Path -Path $PSScriptRoot -ChildPath 'build\*\*\*.psd1' |
        Get-Item |
        Where-Object { $_.BaseName -eq $_.Directory.Parent.Name }

    Update-ModuleManifest -Path $moduleManifest.FullName -DscResourcesToExport $dscResourcesToExport
}
