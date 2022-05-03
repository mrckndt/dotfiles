export GOPATH="$HOME/.go"
export PATH="$HOME/.cargo/bin:$HOME/.gem/bin:$GOPATH/bin:$HOME/.dotfiles/bin:$HOME/.local/bin:$PATH"

if [[ -x /usr/bin/nvim ]] || [[ -x /opt/homebrew/bin/nvim ]]; then
  export EDITOR=nvim
elif [[ -x /usr/bin/vim ]] || [[ -x /opt/homebrew/bin/vim ]]; then
  export EDITOR=vim
fi

export LESS=-R
[[ -x /usr/bin/dircolors ]] && eval "$(dircolors)"
