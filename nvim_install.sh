#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"

# ~/.config/nvim/init.vim
NVIM_CONFIG_DIR="$HOME/.config/nvim"
mkdir -p "$NVIM_CONFIG_DIR"
if [ -f "$NVIM_CONFIG_DIR/init.vim" ]; then
    echo "기존 init.vim 백업 → init.vim.backup"
    mv "$NVIM_CONFIG_DIR/init.vim" "$NVIM_CONFIG_DIR/init.vim.backup"
fi

ln -sfn "$DOTFILES_DIR/.config/nvim/init.vim" "$NVIM_CONFIG_DIR/init.vim"
echo "init.vim 심볼릭 링크 완료"

PLUG_VIM_PATH="$HOME/.local/share/nvim/site/autoload/plug.vim"
if [ ! -f "$PLUG_VIM_PATH" ]; then
    echo "vim-plug 설치 중..."
    curl -fLo "$PLUG_VIM_PATH" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    echo "vim-plug 설치 완료"
else
    echo "vim-plug 이미 설치됨"
fi

echo "Neovim 열어서 :PlugInstall으로 플러그인 설치 필요"
