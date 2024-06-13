$publicScriptRoot = $PSScriptRoot + '/public'
$privateScriptRoot = $PSScriptRoot + '/private'

Get-ChildItem $publicScriptRoot *.ps1 | ForEach-Object {
    Import-Module $_.FullName
}

Get-ChildItem $privateScriptRoot *.ps1 | ForEach-Object {
    Import-Module $_.FullName
}