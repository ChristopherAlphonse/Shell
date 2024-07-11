# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

alias Home='cd ~'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias cls='clear'
alias h='history'
alias c='clear'

alias eztilt="${EZCATER_REPOSITORY_PATH}/eztilt/eztilt"
alias run="${EZCATER_REPOSITORY_PATH}/eztilt/run"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-autocomplete you-should-use)

source $ZSH/oh-my-zsh.sh
source ~/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source "/Users/chrisalphonse/.asdf/asdf.sh"

alias eztilt="/Users/chrisalphonse/code/ezcater/eztilt/eztilt"
alias run="/Users/chrisalphonse/code/ezcater/eztilt/run"

alias psg='ps aux | grep -v grep | grep -i -e VSZ -e'

alias lintts="yarn lint:tsc && yarn lint:tsc-strict"

export EZ_RAILS_DEV_DATA=partial
export EZ_RAILS_VECTOR_DEV_DATA=partial
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" 
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" 
