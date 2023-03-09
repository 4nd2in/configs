# author: 4nd2in

# ------------------------------------------------------------------------------
# ADDITIONAL CONFIGS
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# MAIN CONFIG
# ------------------------------------------------------------------------------

# APPS & FILES ALIASES
alias vimrc='vim $HOME/.vimrc'
alias zshrc='vim $HOME/.zshrc'
alias zshsrc='source $HOME/.zshrc'

# GIT ALIASES
alias add='git add'
alias adda='git add .'
alias amend='git commit --amend'
alias branchmv='git branch -m'
alias commit='git commit -m'
alias commita='git commit -am'
alias clone='git clone'
alias glog='git log --graph --abbrev-commit --decorate --all --oneline'
alias pull='git pull origin'
alias push='git push'
alias restore='git restore'
alias rmstaged='git restore --staged'
alias stash='git stash'
alias stat='git status'
alias subadd='git submodule add'
alias subinit='git submodule init'
alias subup='git submodule update'
alias switch='git switch'
alias switchc='git switch -c'

# SHELL ALIASES
alias ..='cd ..'
alias ll='ls -lah --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'

# EXPORTS
export EDITOR=vim
export VISUAL=vim

# HISTORY
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

# KEYBINDINGS
bindkey -e # -e for emacs -v for vi keybindings
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# OPTIONS
setopt SHARE_HISTORY
# allow '#', '~' and '^' when globbing
setopt extended_glob

# PROMPT
precmd_functions=(render-prompt)

# STYLE
# case-insensitive matching
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# use completion menu
zstyle ':completion:*' menu select

# ------------------------------------------------------------------------------
# HELPER FUNCTIONS
# ------------------------------------------------------------------------------
function render-prompt {
    if (( ${+SSH_CLIENT} )); then
        PROMPT="%F{yellow}SSH%f "
    else
        PROMPT=""
    fi
    PROMPT+="%(1j.%B%%%b .)"
    PROMPT+="%~ "
    PROMPT+="%(?.%F{green}.%F{red})%B▌%b%f "
}
