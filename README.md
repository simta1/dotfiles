# dotfiles

## Setup
```bash
# stow 사용할거라 홈 디렉토리에 둬야 함
git clone https://github.com/simta1/dotfiles.git ~/dotfiles

mkdir -p ~/.config 
```

## zsh
```bash
# bash -> zsh
sudo pacman -S zsh
chsh -s $(which zsh)

# oh-my-zsh 설치
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# powerlevel10k 설치
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
# p10k configure 이후 ~/.p10k.zsh에서 vi_mode 주석 삭제

# zsh plugin(zsh-autosuggestions)
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# zsh plugin(zsh-vi-mode)
git clone https://github.com/jeffreytse/zsh-vi-mode \
  $ZSH_CUSTOM/plugins/zsh-vi-mode

# zsh plugin(zsh-syntax-highlighting)
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# zshrc
sudo pacman -S zoxide bat lazygit fzf bluez sshfs eza trash-cli
yay -S thefuck yt-dlp yazi dragon-drop
stow -v zsh
source ~/.zshrc
```

## nvim (lazyvim)
```bash
# lazyvim
sudo pacman -S neovim
git clone https://github.com/folke/lazy.nvim.git ~/.local/share/nvim/lazy/lazy.nvim
stow -v nvim

# neovide
yay -S neovide
stow -v neovide
```

## System configs
```bash
sudo cp -i ~/dotfiles/etc/conf.d/* /etc/conf.d/
sudo cp -i ~/dotfiles/etc/modprobe.d/* /etc/modprobe.d/
sudo cp -i ~/dotfiles/etc/security/faillock.conf /etc/security/faillock.conf
sudo cp -i ~/dotfiles/etc/pam.d/* /etc/pam.d/
```

## Font
```bash
sudo pacman -S ttf-iosevka-nerd
```

## Scripts
```bash
stow -v bin

mkdir -p ~/.config/systemd/user
stow -v systemd

systemctl --user daemon-reload
systemctl --user enable --now battery-alert.timer
```

## Applications
```bash
cd ~/dotfiles
mkdir -p ~/.config

# alacritty
stow -v alacritty

# bongocat (wayland)
stow -v bongocat

# btop
stow -v btop

# vscode
yay -S visual-studio-code-bin
stow -v Code

# environment.d
stow -v environment.d

# fastfetch
stow -v fastfetch

# ghostty
stow -v ghostty

# git
sudo pacman -S git-delta
stow -v git

# mako
stow -v mako

# mpd, ncmpcpp
stow -v mpd
stow -v ncmpcpp

# mpv
stow -v mpv

# rofi
stow -v rofi

# sway
sudo pacman -S grim slurp wl-clipboard cliphist imagemagick
sudo pacman -S polkit-gnome fprintd
yay -S swaylock-effects
stow -v sway

# bottles
sudo pacman -S flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.usebottles.bottles

# hyprland
sudo pacman -S udiskie hyprpaper hyprpicker xdg-desktop-portal-hyprland xdg-desktop-portal-gtk hyprpolkitagent xorg-xwayland zenity
yay -S wlogout nordzy-hyprcursors clipse hyprshot
stow -v hyprland

# waybar
sudo pacman -S pavucontrol
stow -v waybar

# wezterm
stow -v wezterm

# kitty
sudo pacman -S ttf-jetbrains-mono-nerd
stow -v kitty

# xinitrc, Xmodmap, xprofile, Xresources
stow -v xinitrc
stow -v xmodmap
stow -v xprofile
stow -v xresources

# yazi
sudo pacman -S zip unzip
yay -S ueberzugpp fd chafa zoxide p7zip resvg jq trash-cli blobdrop-git
stow -v yazi
# yazi --debug 로 dependencies 확인

# zathura
stow -v zathura

# zed
stow -v zed

# zellij
stow -v zellij

# opencode
stow -v opencode
```

## sddm theme
```bash
# https://github.com/Keyitdev/sddm-astronaut-theme
sh -c "$(curl -fsSL https://raw.githubusercontent.com/keyitdev/sddm-astronaut-theme/master/setup.sh)"
```
