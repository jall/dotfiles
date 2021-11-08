# This one allows for machine specific/temporary overides.
if [ -f ~/.extra ]; then
  source ~/.extra
fi

test -e "${HOME}/.config/.iterm2_shell_integration.zsh" && source "${HOME}/.config/.iterm2_shell_integration.zsh"

################
# Autocomplete #
################

# brew --prefix zsh-autosuggestions
source /opt/homebrew/opt/zsh-autosuggestions/share/zsh-autosuggestions/zsh-autosuggestions.zsh

###########
# Aliases #
###########

# Improved ls commands.
alias ls='ls -aG'
alias ll='ls -ahlFG'

# Git.
alias s="git status --short --branch --untracked-files=all"
alias d='git diff -- ":(top)" ":(exclude,top)package-lock.json"'
alias dcd='git diff --cached -- ":(top)" ":(exclude,top)package-lock.json"'
# See full formatting options: https://git-scm.com/docs/git-log
# And useful SO answer: https://stackoverflow.com/a/9463536
alias log="git log --oneline"
# With GPG signature and date (but loses some styles for the branches/tags)
# alias log="git log --pretty='format:%C(auto,yellow)%h%C(auto,magenta)% G? %C(auto,blue)%>(15,trunc)%ar %C(auto,red)%d %C(auto,reset)%s'"
alias gaa="git add ."
alias gaac="git add . && git co"
alias gam="git amend"
alias gamn="git amend --no-edit"
alias gra="git reset ."

# Python.
alias py='python3'

alias f="fzf"

###########
# Exports #
###########

# Add timestamps to command history
# export HISTTIMEFORMAT="%y-%m-%d %T "

# Add some colour to grep by default
export GREP_OPTIONS='--color=auto'

# GPG requires this to prompt for signing correctly, e.g. when signing git commits
export GPG_TTY=$TTY

# Directory
export WORK_DIR="${HOME}/Work"

# Use fd (or ripgrep) so fzf doesn't search gitignored files by default
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
# Allows fuzzy finding in the middle of expressions via CTRL-T
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Base directories for `cd`
if test “${PS1+set}”; then
  export CDPATH="${CDPATH}:${HOME}/Work"
fi

# brew env vars
eval "$(/opt/homebrew/bin/brew shellenv)"

#############
# Functions #
#############

# Generates random alphanumeric string, suitable for passwords etc.
# Optional argument for length of string; defaults to 24.
random() {
  base64 /dev/urandom | tr -dc '[:alnum:]' | fold -w "${1:-24}" | head -n 1
}

# Check if a file is executable
is-executable() {
  local BIN=$(command -v "$1" 2>/dev/null)
  if [[ ! $BIN == "" && -x $BIN ]]; then true; else false; fi
}

# Extract many types of compressed files
# Source: http://nparikh.org/notes/zshrc.txt
extract() {
  if [ -f "$1" ]; then
    case "$1" in
    *.tar.bz2) tar -jxvf "$1" ;;
    *.tar.gz) tar -zxvf "$1" ;;
    *.bz2) bunzip2 "$1" ;;
    *.dmg) hdiutil mount "$1" ;;
    *.gz) gunzip "$1" ;;
    *.tar) tar -xvf "$1" ;;
    *.tbz2) tar -jxvf "$1" ;;
    *.tgz) tar -zxvf "$1" ;;
    *.zip) unzip "$1" ;;
    *.ZIP) unzip "$1" ;;
    *.pax) cat "$1" | pax -r ;;
    *.pax.Z) uncompress "$1" --stdout | pax -r ;;
    *.Z) uncompress "$1" ;;
    *) echo "'$1' cannot be extracted/mounted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file to extract"
  fi
}

# Create a data URL from a file
data-url() {
  local MIMETYPE=$(file --mime-type "$1" | cut -d ' ' -f2)
  if [[ $MIMETYPE == "text/*" ]]; then
    MIMETYPE="${MIMETYPE};charset=utf-8"
  fi
  echo "data:${MIMETYPE};base64,$(openssl base64 -in "$1" | tr -d '\n')"
}

# Tries to fast forward pull every git repo in the provided/current directory.
pull-all() {
  local dir=${1:-$(pwd)}
  dir=${dir%/}

  echo "$dir"/*/.git |
    sed 's:\/.git::g' |
    tr ' ' '\n' |
    xargs -n1 -P10 git-fetch-project

  echo "Last fetch: $(cat ~/.config/me/pull-all-last-fetch-date 2>/dev/null)"
  echo "Fetched at: $(date | tee ~/.config/me/pull-all-last-fetch-date)"
}

add-to-path() {
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    PATH="$1${PATH:+":$PATH"}"
  fi
}

####################
# Shell navigation #
####################

# Use bash-like word definitions for navigation and operations
autoload -Uz select-word-style
select-word-style bash

bindkey "\e\e[D" backward-word
bindkey "\e\e[C" forward-word

###########
# Options #
###########

# navigate to directories if entered without a command
setopt AUTO_CD

# command typo correction
setopt CORRECT

# enable shell command history
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY
setopt APPEND_HISTORY
# adds commands as they are typed, not at shell exit
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS

##########
# Prompt #
##########

# https://starship.rs/
eval "$(starship init zsh)"
