export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export NODE_PATH="/usr/local/lib/node:/usr/local/lib/node_modules"

# brew completion
if [ -f /usr/local/bin/brew ]; then
  source `brew --prefix`/etc/bash_completion.d/git-completion.bash
  source `brew --prefix`/etc/bash_completion.d/git-flow-completion.bash
  source `brew --prefix`/Library/Contributions/brew_bash_completion.sh
fi

# Local configs
if [ -f ~/.localbash ]; then
  . ~/.localbash
fi

export GREP_OPTIONS="--color"

# Add RVM to PATH for scripting
PATH=$PATH:$HOME/.rvm/bin

# Load RVM function
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# tmuxinator
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

# Git branch
# PS1='\[\033[G\]\[\033[1;37m\]\u ✭ \[\033[1;32m\]\h\[\033[00m\]\[\033[34m\] λ \[\033[1;34m\]\w\[\033[1;35m\]$(    __git_ps1 " (%s)") \[\033[1;37m\]→\[\033[00m\] '
function _update_ps1() {
  export PS1="$(~/.powerline-bash.py $?)"
}
export PROMPT_COMMAND="_update_ps1"

# Use MacVim
alias vim="/usr/local/bin/mvim -v"
alias vimdiff="/usr/local/bin/mvim -v mvimdiff"

# Bash aliases
alias l="ls -hG"
alias ll="ls -lhG"
alias la="ls -alhG"
alias psg="ps aux | grep"
alias k9="kill -9"
alias json='python -mjson.tool'
alias tmux="TERM=screen-256color-bce tmux"

# Ruby and Rails aliases
alias be="bundle exec"
alias bi="bundle check || bundle install"
alias bu="bundle update"
alias bo="bundle open"
alias bc="bundle check"

# python webserver
alias server="python -m SimpleHTTPServer"

# fix song without extension
alias fixmp3="for f in *; do mv \"$f\" \"$f.mp3\"; done;"

# Make vim the default editor
export EDITOR="vim"

# Don’t clear the screen after quitting a manual page
export MANPAGER="less -X"

# Larger bash history (allow 32³ entries; default is 500)
export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL=ignoredups

# Make some commands not show up in history
export HISTIGNORE="l:ll:la:ls:ls *:cd:cd ..:cd -:pwd;exit:date:* --help"

# Toggle OS X hidden files
alias hidden_files="defaults write com.apple.finder AppleShowAllFiles"

# MAC manipulators
alias  random_mac='sudo ifconfig en0 ether `openssl rand -hex 6 | sed "s/\(..\)/\1:/g; s/.$//"`'
alias restore_mac='sudo ifconfig en0 ether 60:c5:47:8f:1a:e6'
