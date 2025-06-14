# dotfiles

### 설치방법
1. zsh, oh-my-zsh 설치
```
sudo pacman -S zsh
chsh -s /bin/zsh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

2. powerlevel10k 설치
```
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

3. zsh plugin 설치
```
# autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

4. nvim 설치
```
sudo pacman -S neovim
```

5. dotfiles 적용
```bash
git clone https://github.com/simta1/dotfiles.git ~/dotfiles
cd ~/dotfiles

# ~/.config/nvim/init.vim
chmod +x nvim_install.sh
./nvim_install.sh
# 이후 `:PlugInstall`로 플러그인 설치

# ~/.zshrc
chmod +x zsh_install.sh
./zsh_install.sh
source ~/.zshrc
```

6. batcat 설치
```
sudo pacman -S bat
```
~/.ssh/config
