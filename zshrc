# zmodload zsh/zprof
# setopt prompt_subst; zmodload zsh/datetime; PS4='+[$EPOCHREALTIME]%N:%i> '; set -x

autoload -U +X bashcompinit && bashcompinit
autoload -U +X compinit && compinit

# zsh configs {{{
bindkey -e
export REPORTTIME=10	# display how long all tasks over 10 seconds take
# }}}

ZSH_THEME="minimal"
export LC_ALL=en_US.UTF-8
source $ZSH/oh-my-zsh.sh
plugins=(git docker terraform)

# zsh history {{{
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.

# Enable ^, see https://github.com/robbyrussell/oh-my-zsh/issues/449#issuecomment-6973326
setopt NO_NOMATCH
setopt AUTOCD

export WORDCHARS=''
export CLICOLOR=1
export BLOCK_SIZE=human-readable # https://www.gnu.org/software/coreutils/manual/html_node/Block-size.html
export HISTSIZE=10000000
export SAVEHIST=10000000
export HISTFILE=~/.zsh_history
# }}}

# aliases {{{
alias ll='exa -Flh --git'
alias la='ll -a'
alias lt='ll -T'
alias vim="nvim"
alias vi="nvim"
alias k="kubectl"
# }}}

# Setup fzf {{{
if [[ ! "$PATH" == *$HOMEBREW_PREFIX/opt/fzf/bin* ]]; then
  export PATH="$HOMEBREW_PREFIX/opt/fzf/bin:$PATH"
fi
[[ $- == *i* ]] && source "$HOMEBREW_PREFIX/opt/fzf/shell/completion.zsh" 2> /dev/null
source "$HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.zsh"
# }}}

# local AWS development helpers {{{
alias sns='dotenv aws --endpoint-url http://localhost:4100 sns'
alias sqs='dotenv aws --endpoint-url http://localhost:4100 sqs'
alias dynamodb='dotenv aws --endpoint-url http://localhost:8889 dynamodb'
# }}}

# zprof
#

# vim:foldmethod=marker:foldlevel=0:nomodeline:

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /Users/lucas.souza/bin/consul consul
complete -o nospace -C /Users/lucas.souza/bin/vault vault
source <(kubectl completion zsh)

alias java='~/Java/bin/java'
