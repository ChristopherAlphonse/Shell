Import-Module posh-git
Import-Module -Name Terminal-Icons
Import-Module PSFzf
$omp_config = Join-Path $PSScriptRoot ".\ChrisDev.omp.json"
oh-my-posh --init --shell pwsh --config $omp_config | Invoke-Expression
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineOption -PredictionSource History
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'
Set-Alias -Name vim -Value nvim
Set-Alias -Name touch -Value New-Item
Set-Alias ll ls
Clear-Host