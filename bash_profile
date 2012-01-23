export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export NODE_PATH="/usr/local/lib/node:/usr/local/lib/node_modules"

# git-flow completion
. `brew --prefix`/etc/bash_completion.d/git-flow-completion.bash

export GREP_OPTIONS="--color"

# Load RVM function
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

# Git branch
PS1='\[\033[1;37m\][\u@\[\033[1;32m\]\h\[\033[00m\]\[\033[34m\]:\[\033[1;34m\]\w\[\033[1;35m\]$(    __git_ps1 " (%s)")\[\033[1;37m\]]\$\[\033[00m\] '

# Use MacVim
alias vim="/usr/local/bin/mvim -v"

# Bash aliases
alias l="ls -hG"
alias ll="ls -lhG"
alias la="ls -alhG"
alias psg="ps aux | grep"
alias k9="kill -9"

# Ruby and Rails aliases
alias be="bundle exec"
alias bi="bundle install"
alias bu="bundle update"

# Git Completion
source ~/.git-completion.sh

# Make vim the default editor
export EDITOR="vim"

# Don’t clear the screen after quitting a manual page
export MANPAGER="less -X"

# Larger bash history (allow 32³ entries; default is 500)
export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL=ignoredups

# Make some commands not show up in history
export HISTIGNORE="ls:ls *:cd:cd -:pwd;exit:date:* --help"

###-begin-npm-completion-###
#
# npm command completion script
#
# Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm
#

COMP_WORDBREAKS=${COMP_WORDBREAKS/=/}
COMP_WORDBREAKS=${COMP_WORDBREAKS/@/}
export COMP_WORDBREAKS

if complete &>/dev/null; then
  _npm_completion () {
    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$COMP_CWORD" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${COMP_WORDS[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
  }
  complete -F _npm_completion npm
elif compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
###-end-npm-completion-###