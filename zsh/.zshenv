export GOPATH="$HOME/.go"
export PATH="$HOME/.cargo/bin:$HOME/.gem/bin:$GOPATH/bin:$HOME/.dotfiles/bin:$PATH:$HOME/.local/bin"

if [ -n "$(type -p 'nvim')" ]; then
  export EDITOR=nvim
fi

export LESS="-FRSMKI"
export SYSTEMD_LESS="FRSMKI"
