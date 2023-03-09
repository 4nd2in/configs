if status is-interactive
    # Commands to run in interactive sessions can go here
end

# APPS & FILES ALIASES
alias fishrc='vim $HOME/.config/fish/config.fish'
alias fishsrc='source $HOME/.config/fish/config.fish'
alias vimrc='vim $HOME/.vimrc'
alias zshrc='vim $HOME/.zshrc'
alias zshsrc='source $HOME/.zshrc'

# GIT ALIASES
alias branch='git branch'
alias clone='git clone'
alias glog='git log --graph --abbrev-commit --decorate --all --oneline'
alias main='git switch main'
alias pull='git pull origin'
alias push='git push'
alias stash='git stash'
alias suba='git submodule add'
alias subi='git submodule init'
alias subu='git submodule update'
alias swi='git switch'
alias swic='git switch -c'

# SHELL ALIASES
alias ..='cd ..'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'

# ENV
set -Ux EDITOR vim
set -Ux VISUAL vim

# remove greeting
set -g fish_greeting

# AT END STARSHIP
starship init fish | source
