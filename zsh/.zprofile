export PATH="$HOME/.local/bin:$PATH"

if [ -d "$HOME/.vim/plugged/vim-superman/bin" ]; then
    export PATH="$HOME/.vim/plugged/vim-superman/bin:$PATH"
fi

export EDITOR=nvim
export VISUAL=nvim
export ZDOTDIR="$HOME/.config/zsh"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export RANGER_LOAD_DEFAULT_RC=FALSE
export BAT_THEME=Dracula
export GO111MODULE=on
export GOPROXY=https://goproxy.cn

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
    exec startx
fi
