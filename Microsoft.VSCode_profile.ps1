$initdir = join-path -Path $PSScriptRoot -ChildPath "autoload"

Get-ChildItem -Path $initdir -Filter "*.ps1" | ForEach-Object {
  . $_.FullName
}
