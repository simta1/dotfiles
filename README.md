# dotfiles

### 설치방법
1. zsh 설치
```bash
sudo pacman -S zsh
zsh --version # 설치확인
chsh -s /bin/zsh
# 로그아웃 후 터미널 재실행하면 This is the Z Shell configuration 어쩌구 나오는데 q하면 됨

# oh-my-zsh 설치
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

1. 스크립트 실행
```bash
git clone https://github.com/simta1/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

2. Neovim 플러그인 설치   
`nvim` 실행해서 `:PlugInstall`로 플러그인 설치

3. Zsh 설정 적용   
```bash
source ~/.zshrc
```

### 포함되어있는 설정파일들
- **Neovim (`~/.config/nvim/init.vim`)**
- **Zsh (`~/.zshrc`)**


