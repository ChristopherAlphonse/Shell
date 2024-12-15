# set PowerShell to UTF-8
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding


Import-Module posh-git
Import-Module PowerShellGet
Import-Module -Name Terminal-Icons


# Fzf
Install-Module -Name PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'


# Env
$env:GIT_SSH = "C:\Windows\system32\OpenSSH\ssh.exe"

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
        [Parameter(Position = 0, Mandatory = $true)]
        [string]$branchName,

        [switch]$Create
    )

    try {

        $branchExistsLocally = git branch --list "$branchName" | ForEach-Object { $_.Trim() }
        $branchExistsRemotely = git ls-remote --heads origin "$branchName" | ForEach-Object { $_.Trim() }

        if ($branchExistsLocally -or $branchExistsRemotely) {
            if ($Create) {
                Write-Error "Cannot create branch '$branchName'. It already exists."
                return
            }
            git switch $branchName
            Write-Output "Switched to branch '$branchName'."
        } else {
            if ($Create) {
                git switch -c $branchName
                Write-Output "Created and switched to branch '$branchName'."
            } else {

                git switch --track origin/$branchName
                Write-Output "Switched to remote tracking branch '$branchName'."
            }
        }
    } catch {
        Write-Error "An error occurred: $_"
    }
}


function rebase-f {
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

function rebase-i{
    param(
        [Parameter(Mandatory = $true)]
        [int]$count
    )

    try {

        git rebase -i HEAD~$count
        Write-Output "Interactive rebase started for the last $count commits."
    } catch {
        Write-Error "An error occurred while attempting the interactive rebase: $_"
    }
}


Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -HistoryNoDuplicates:$true
Set-PSReadLineOption -PredictionViewStyle ListView


# Set aliases
Set-Alias -Name search -Value find-file
Set-Alias -Name touch -Value New-Item
Set-Alias -Name ll -Value Get-ChildItem
Set-Alias -Name folder -Value mkdir
Set-Alias -Name g -Value git
Set-Alias -Name gs -Value "git status"
Set-Alias -Name ga -Value "git add"


Set-Alias -Name cls -Value "Clear-Host"
Set-Alias -Name h -Value "Get-History"
Set-Alias -Name c -Value "Clear-Host"
Set-Alias -Name ls -Value Get-ChildItem
Set-Alias -Name be -Value "bundle exec"
Set-Alias grep findstr


function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}
