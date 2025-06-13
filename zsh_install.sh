#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"

# ~/.zshrc
if [ -f "$HOME/.zshrc" ]; then
    echo "기존 .zshrc 백업 → .zshrc.backup"
    mv "$HOME/.zshrc" "$HOME/.zshrc.backup"
fi
ln -s "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
echo ".zshrc 심볼릭 링크 완료"

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "oh-my-zsh가 설치 필요:"
    echo ""
    echo "sh -c \"\$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\""
    echo ""
fi
