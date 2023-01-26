$omp_config = Join-Path $PSScriptRoot ".\ChrisDev.omp.json"
oh-my-posh --init --shell pwsh --config $omp_config | Invoke-Expression

Import-Module posh-git
Import-Module -Name Terminal-Icons
Import-Module PSFzf
Import-Module PowerShellGet


Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineOption -PredictionSource History
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

Set-alias -Name vim -Value nvim
Set-alias -Name touch -Value New-Item
Set-alias ll ls
set-alias -name pn -value pnpm
set-alias rm Remove-Item -Recurse -Force



new-alias grep findstr

Clear-Host
