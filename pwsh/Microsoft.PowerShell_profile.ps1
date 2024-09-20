
Import-Module posh-git
Import-Module PowerShellGet
Import-Module posh-git
Import-Module -Name Terminal-Icons
Import-Module PowerShellGet



# Hash functions
function md5 { Get-FileHash -Algorithm MD5 $args }
function sha1 { Get-FileHash -Algorithm SHA1 $args }
function sha256 { Get-FileHash -Algorithm SHA256 $args }

# Base64 decode function
function atob {
    param(
        [string]$userInput
    )

    $encodedString = $userInput
    $decodedResult = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($encodedString))

    Write-Output $decodedResult
}

# Note
# Alt + t or `option + t` split on the y axis
# Alt + b or `option + b` split on the x axis

# Initialize Oh My Posh with a specific theme configuration
oh-my-posh init pwsh --config 'C:\Users\chris-desktop\AppData\Local\Programs\oh-my-posh\themes\blue-owl.omp.json' | Invoke-Expression

# Function to perform Git operations lazily
function lazyg {
    param(
        [string]$userInput
    )
    git pull
    git add .
    git commit -m $userInput
    git push
}

# Set convenient aliases
Set-Alias -Name search -Value find-file
Set-Alias -Name touch -Value New-Item
Set-Alias -Name ll -Value Get-ChildItem
Set-Alias -Name folder -Value mkdir
Set-Alias -Name g -Value git
Set-alias -Name ls -Value Get-ChildItem

# Function to find files by name
function find-file($name) {
    Get-ChildItem -recurse -filter "*${name}*" -ErrorAction SilentlyContinue | ForEach-Object {
        $place_path = $_.directory
        Write-Output "${place_path}\${_}"
    }
}

# Function to unzip files
function unzip ($file) {
    Write-Output("Extracting", $file, "to", $pwd)
    $fullFile = Get-ChildItem -Path $pwd -Filter .\cove.zip | ForEach-Object { $_.FullName }
    Expand-Archive -Path $fullFile -DestinationPath $pwd
}



# Function to create a file
function touch($file) {
    "" | Out-File $file -Encoding ASCII
}

# Function to kill a process by name
function pkill($name) {
    Get-Process $name -ErrorAction SilentlyContinue | Stop-Process
}



# Set PSReadLine options
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineOption -PredictionSource History



