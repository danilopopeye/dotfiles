# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
  source ~/.zplug/init.zsh && zplug update --self
fi

source ~/.zplug/init.zsh

zplug "junegunn/fzf", as:command, use:'bin/fzf-tmux'
zplug "junegunn/fzf-bin", from:gh-r, as:command, rename-to:fzf, use:"*linux*amd64*"
zplug "stedolan/jq", from:gh-r, as:command, rename-to:jq
zplug "yudai/sshh", as:command
zplug "b4b4r07/httpstat", as:command, use:'(*).sh', rename-to:'$1'

zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "plugins/httpie", from:oh-my-zsh
zplug "plugins/ssh-agent", from:oh-my-zsh
zplug "plugins/safe-paste", from:oh-my-zsh

zplug "~/.dotfiles", from:local
zplug "~/.dotfiles", from:local, as:command, use:"bin/*"

zplug "zsh-users/zsh-completions"
# zplug "zsh-users/zsh-autosuggestions" # configure
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# Install plugins if there are plugins that have not been installed
if ! zplug check; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

alias ll="ls -lh"
# alias grep="rg"

export EDITOR=nvim
export LC_ALL="en_US.UTF-8"
export PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:./bin:~/.npm-global/bin
export DOCKER_HOST="tcp://127.0.0.1:2376"

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--height 40% --inline-info"
export FZF_CTRL_R_OPTS='--exact'
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
export FZF_TMUX="$TMUX"

# rbenv & pyenv
export PATH="$HOME/.rbenv/bin:$HOME/.pyenv/bin:$PATH"
eval "$(rbenv init -)"
eval "$(pyenv init -)"

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

# Enable ^, see https://github.com/robbyrussell/oh-my-zsh/issues/449#issuecomment-6973326
setopt NO_NOMATCH
setopt AUTOCD

export CLICOLOR=1
export BLOCK_SIZE=human-readable # https://www.gnu.org/software/coreutils/manual/html_node/Block-size.html
export HISTSIZE=11000
export SAVEHIST=10000
export HISTFILE=~/.zsh_history

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
