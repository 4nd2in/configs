# APPS & FILES ALIASES
alias vimrc='vim $HOME/.vimrc'
alias zshrc='vim $HOME/.zshrc'
alias zshsrc='source $HOME/.zshrc'
alias hosts='vim /Users/andrin/.ssh/known_hosts'
alias smoca='cd $HOME/smoca'
alias me='cd $HOME/me'

# GIT ALIASES
alias branch='git branch'
alias clone='git clone'
alias glog='git log --graph --abbrev-commit --decorate --all --oneline'
alias main='git switch main'
alias merge='git mergetool'
alias pull='git pull origin'
alias push='git push'
alias stash='git stash'
alias suba='git submodule add'
alias subi='git submodule init'
alias subu='git submodule update'
alias swi='git switch'
alias swic='git switch -c'

# RAILS ALIASES
alias rg='rails generate'
alias rg:mo='rails generate model'
alias rg:mi='rails generate migration'
alias rg:v='rails generate view'
alias rg:c='rails generate controller'
alias rdb:c='rails db:create'
alias rdb:d='rails db:drop'
alias rdb:s='rails db:seed'
alias rdb:m='rails db:migrate'
alias rdb:cms='rails db:create db:migrate db:seed'

# SHELL ALIASES
alias l='ls -lah'
alias la='ls -lah'
alias ..='cd ..'
alias ...='cd ../..'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'

# ENV
export EDITOR=vim
export VISUAL=vim

# KEYBINDS
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward
bindkey -e

# inline command edit
autoload edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line

# HISTORY
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt SHARE_HISTORY

# STYLE
# case-insensitive matching
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# use completion menu
zstyle ':completion:*' menu select

# PROMPT
precmd_functions=(render-prompt)

function render-prompt {
  PROMPT=""
  PROMPT+="%(1j.%B%%%b .)"
  PROMPT+="%~ "
  PROMPT+="%(?.%F{green}.%F{red})%B❯%b%f "
}

# CONVENIENCE

# allow #, ~ and ^ when globbing
setopt extended_glob
