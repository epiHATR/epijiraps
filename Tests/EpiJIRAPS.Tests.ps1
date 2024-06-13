$ModulePath = Split-Path -Path $PSScriptRoot -Parent
$ModuleName = Split-Path -Path $ModulePath -Leaf

# Make sure one or multiple versions of the module are not loaded
Get-Module -Name $ModuleName | Remove-Module

# Import the module and store the information about the module
$ModuleInformation = Import-Module -Name "$ModulePath\$ModuleName.psd1" -PassThru
$ModuleInformation | Format-List

# Get the functions present in the Manifest
$ExportedFunctions = $ModuleInformation.ExportedFunctions.Values.Name

# Get the functions present in the Public folder
$PS1Functions = Get-ChildItem -Path "$ModulePath\Public\*.ps1"

Describe "$ModuleName Module - Testing Manifest File (.psd1)" {
    Context "Manifest" {
        It "Should contain RootModule" {
            $ModuleInformation.RootModule | Should Not BeNullOrEmpty
        }
    }
}

Get-Module -Name $ModuleName | Remove-Module