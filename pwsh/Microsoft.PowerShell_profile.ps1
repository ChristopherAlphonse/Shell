
Import-Module posh-git
Import-Module PowerShellGet
Import-Module -Name Terminal-Icons


function md5 { Get-FileHash -Algorithm MD5 $args }
function sha1 { Get-FileHash -Algorithm SHA1 $args }
function sha256 { Get-FileHash -Algorithm SHA256 $args }


function atob {
    param([string]$userInput)
    try {
        $decodedResult = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($userInput))
        Write-Output $decodedResult
    } catch {
        Write-Error "Invalid Base64 string."
    }
}


oh-my-posh init pwsh --config 'C:\Users\chris-desktop\AppData\Local\Programs\oh-my-posh\themes\blue-owl.omp.json' | Invoke-Expression


function lazyg {
    param([string]$commitMessage)
    git pull
    git add .
    git commit -m $commitMessage
    git push
}



function find-file($name) {
    Get-ChildItem -recurse -filter "*${name}*" -ErrorAction SilentlyContinue | ForEach-Object {
        Write-Output "$($_.Directory)\$($_.Name)"
    }
}


function unzip ($file) {
    Write-Output "Extracting $file to $pwd"
    Expand-Archive -Path $file -DestinationPath $pwd -Force
}


function touch($file) {
    "" | Out-File $file -Encoding ASCII
}


function pkill($name) {
    Get-Process -Name $name -ErrorAction SilentlyContinue | Stop-Process
}


function lintts {
    yarn format
    yarn lint:tsc
    yarn lint:tsc-strict
    yarn lint:js
    yarn fix:js
    yarn lint:prettier
    yarn fix:prettier
}

function gsw {
    param(
        [string]$branchName
    )

    if (-not $branchName) {
        Write-Error "You must provide a branch name."
        return
    }

    try {

        git show-ref --verify --quiet "refs/heads/$branchName"
        if ($LASTEXITCODE -eq 0) {
            git switch $branchName
        } else {
            Write-Output "Branch '$branchName' does not exist locally. Attempting to check it out remotely..."
            git switch -c $branchName --track origin/$branchName
        }
    } catch {
        Write-Error "Failed to switch to branch '$branchName': $_"
    }
}


function gsw-rebase {
    param(
        [Parameter(Mandatory = $true)]
        [string]$t,

        [Parameter(Mandatory = $true)]
        [string]$f
    )

    try {

        git switch $t
        Write-Output "Switched to branch '$t'."


        git fetch
        Write-Output "Fetched updates from remote."


        git switch $f
        Write-Output "Switched to branch '$f'."


        git rebase $t
        Write-Output "Rebased '$f' onto '$t'."


        while ($LASTEXITCODE -ne 0) {
            Write-Host "Rebase conflict detected. Resolve conflicts, then run 'git rebase --continue'."
            pause
            git rebase --continue
        }


        git push -f
        Write-Output "Force-pushed branch '$f' to the remote."
    } catch {
        Write-Error "An error occurred: $_"
    }
}


Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineOption -PredictionSource History


# Set aliases
Set-Alias -Name search -Value find-file
Set-Alias -Name touch -Value New-Item
Set-Alias -Name ll -Value Get-ChildItem
Set-Alias -Name folder -Value mkdir
Set-Alias -Name g -Value git
Set-Alias -Name gs -Value "git status"
Set-Alias -Name ga -Value "git add"
Set-Alias -Name gc -Value "git commit"
Set-Alias -Name gp -Value "git push"
Set-Alias -Name cls -Value "Clear-Host"
Set-Alias -Name h -Value "Get-History"
Set-Alias -Name c -Value "Clear-Host"
Set-Alias -Name ls -Value Get-ChildItem
Set-Alias -Name be -Value "bundle exec"
