eval "$(rbenv init -)"

bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward
autoload -Uz compinit && compinit #git branch lookup
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # case-insensitive matching
zstyle ':completion:*' menu select # use completion menu

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt SHARE_HISTORY #share history
setopt extended_glob # allow #, ~ and ^ when globbing

function git-head-name {
    local COMMIT=${1:-HEAD}
    local NAME=$(git symbolic-ref "${COMMIT}" 2>& -)

    if [[ -n "${NAME}" ]]; then
        echo ${NAME#refs/(head|tag)s/}
    else
        git rev-parse --short "${COMMIT}"
    fi
}

function git-count-staged-files {
    local FILES=($(git diff --name-only --staged))
    print ${#FILES[@]}
}

function git-count-untracked-files {
    local FILES=($(git ls-files --others --exclude-standard))
    print ${#FILES[@]}
   
}

function git-count-modified-files {
    local FILES=($(git ls-files --modified))
    print ${#FILES[@]}
}

# Prints all tags for $COMMIT separated by $DELIMITER.
# Arguments
#   1 COMMIT: defaults to "HEAD"
#   2 DELIMITER: defaults to " "
function git-tags {
    declare COMMIT=${1:-HEAD}
    declare DELIMITER=${2:- }
    declare TAGS=($(git tag --contains "$COMMIT"))

    print ${(pj:$DELIMITER:)${TAGS}}
}

function git-is-repo-empty {
    if ! git-is-repo; then
        false
    elif git rev-parse HEAD &> /dev/null; then
        false
    else
        true
    fi
}

function git-is-repo {
    return $(git rev-parse &> /dev/null)
}

function git-is-inside-worktree {
    if [[ $(git rev-parse --is-inside-work-tree &> /dev/null) == "true" ]]; then
        true
    else
        false
    fi
}

function git-render-prompt {
    if ! git-is-repo; then
        return
    fi

    local GIT_PROMPT="$*"
    local GIT_CLEAN=1

    local GIT_STAGED_COUNT=$(git-count-staged-files)
    if [[ $GIT_PROMPT == *\%staged-flag* ]]; then
        if [[ GIT_STAGED_COUNT -eq 0 ]]; then
            local STAGED_FLAG=''
        else
            local STAGED_FLAG=" 📫 %F{green}(${GIT_STAGED_COUNT})"
            GIT_CLEAN=0
        fi
        GIT_PROMPT=${GIT_PROMPT//\%staged-flag/$STAGED_FLAG}
    fi

    local GIT_MODIFIED_COUNT=$(git-count-modified-files)
    if [[ $GIT_PROMPT == *\%modified-flag* ]]; then
        if [[ GIT_MODIFIED_COUNT -eq 0 ]]; then
            local MODIFIED_FLAG=''
        else
            local MODIFIED_FLAG=" 🛠 %F{yellow}($GIT_MODIFIED_COUNT)"
            GIT_CLEAN=0
        fi

        GIT_PROMPT=${GIT_PROMPT//\%modified-flag/$MODIFIED_FLAG}
    fi

    local GIT_UNTRACKED_FILES=$(git-count-untracked-files)
    if [[ GIT_UNTRACKED_FILES -ne 0 ]]; then
         GIT_CLEAN=0
         GIT_PROMPT="${GIT_PROMPT} 📬 %F{red}(${GIT_UNTRACKED_FILES})"
    fi


    if [[ $GIT_CLEAN -eq 1 ]]; then
        GIT_PROMPT="%F{green}${GIT_PROMPT}"
    else
        GIT_PROMPT="🛑 %F{yellow}${GIT_PROMPT}"
    fi

    local -A fns=(
    '%branch' git-head-name
    '%staged' git-count-staged-files
    '%modified' git-count-modified-files
    )

    declare k
    for k in ${(k)fns[@]}; do
        GIT_PROMPT=${GIT_PROMPT//$k/$(${fns[$k]})}
    done

    GIT_PROMPT=${GIT_PROMPT/\%tags/$(git-tags HEAD ${DELIMITER:-\|})}


    print $GIT_PROMPT
}


# Prompt settings {{{1
precmd_functions=(render-prompt)

function render-prompt {
    if (( ${+SSH_CLIENT} )); then
        PROMPT="%F{yellow}SSH%f "
    else
        PROMPT=""
    fi
    PROMPT+="%(1j.%B%%%b .)"
    PROMPT+="%~ "
    PROMPT+="%(?.%F{green}.%F{red})%B▌%b%f "

    if git-is-repo-empty; then
        RPROMPT="%F{magenta}empty%f"
    else
        RPROMPT=$(git-render-prompt "%branch%staged-flag%modified-flag%f")
    fi
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Android paths
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

# Java paths
export JAVA_11_HOME=$(/usr/libexec/java_home -v11)
alias java11='export JAVA_HOME=$JAVA_11_HOME'

# Doom Emacs path
export PATH=$PATH:$HOME/.emacs.d/bin

# Applications 
export PATH=$PATH:$HOME/Applications
