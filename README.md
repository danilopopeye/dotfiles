# dotfiles

Dependencies not automagically managed:

1. `eget`
2. `tmux-plugins/tpm`
3. `starship`
4. `atuin`

## stow

```sh
cd "$HOME/.dotfiles"
stow -v -R --dotfiles .
```

## eget

```sh
BINPATH="$HOME/.local/bin"
mkdir -p "$BINPATH"

curl -o eget.sh https://zyedidia.github.io/eget.sh
shasum -a 256 eget.sh # verify with hash below
bash eget.sh

mv eget "$BINPATH"
```

## starship

```sh
starship init zsh > $HOME/.local/share/starship-init.zsh

# add to .zshlocal
cat << EOF >> "$HOME/.zshlocal"

source "$HOME/.local/share/starship-init.zsh"
EOF
```

### WSL2

```
alias clip=/mnt/c/Windows/System32/clip.exe
```

## atuin

```sh
atuin init --disable-up-arrow zsh > $HOME/.local/share/atuin-init.zsh
source "$HOME/.local/share/atuin-init.zsh"
```
