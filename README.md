# dotfiles

### 설치방법
1. zsh 설치
2. powerlevel10k 설치
```
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```
3. zsh plugin 설치
```
# autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# syntax-highlighting (※ 얘는 반드시 plugins 리스트에서 마지막에 와야 함)
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

4. nvim 설치

5.
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
