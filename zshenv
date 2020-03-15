# source local config
[[ -f $HOME/.zshlocal ]] && source $HOME/.zshlocal

export ZSH=$HOME/.oh-my-zsh
export PIP_CERT=$HOME/certificate-chain.pem
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export PDNSCLI_CONFIG_PATH=$HOME
# export SSL_CERT_FILE=/etc/ssl/certs/ca-c6bank.pem
export AWS_SDK_LOAD_CONFIG=1
export JAVA_HOME=$HOME/Java

# set PATH so it includes user's private bin if it exists
[[ -d "$HOME/bin" ]] && PATH="$HOME/bin:/Users/lucas.souza/Library/Python/3.7/bin:$PATH"

# set PATH so it includes user's private bin if it exists
[[ -d "$HOME/.local/bin" ]] && PATH="$HOME/.local/bin:$PATH"

# (Home|Linux)brew {{{
linuxbrew="/home/linuxbrew/.linuxbrew"
if [ -d $linuxbrew ]; then
  export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
else
  export HOMEBREW_PREFIX="$HOME/Homebrew"
fi

export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_CELLAR="$HOMEBREW_PREFIX/Cellar"
export HOMEBREW_REPOSITORY="$HOMEBREW_PREFIX/Homebrew"
export PATH="$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH"
export MANPATH="$HOMEBREW_PREFIX/share/manpages:$MANPATH"
export INFOPATH="$HOMEBREW_PREFIX/share/info:$INFOPATH"
# }}}

# goenv + Go {{{
export GOPATH=$HOME/code/go
export GOENV_SHELL=zsh

export PATH="$HOME/.goenv/shims:$GOPATH/bin:$PATH"
# source "$HOMEBREW_CELLAR/goenv/1.23.3/completions/goenv.zsh"
goenv() {
  local command
  command="$1"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  rehash|shell)
    eval "$(goenv "sh-$command" "$@")";;
  *)
    command goenv "$command" "$@";;
  esac
}
# }}}

# pyenv + Python {{{
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PYENV_ROOT/shims:$PATH"

# command pyenv rehash 2>/dev/null
pyenv() {
  local command
  command="${1:-}"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  rehash|shell)
    eval "$(pyenv "sh-$command" "$@")";;
  *)
    command pyenv "$command" "$@";;
  esac
}
# }}}

# fzf + fzf-tmux {{{
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2>/dev/null'
export FZF_DEFAULT_OPTS="--height 40% --inline-info"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat -p --color always -r :50 {}'"
export FZF_CTRL_R_OPTS='--exact'
export FZF_ALT_C_OPTS="--preview 'exa -TF {} | head -50'"
export FZF_TMUX="$TMUX"
# }}}

# misc
export EDITOR=nvim

# vim:foldmethod=marker:foldlevel=0:nomodeline:


