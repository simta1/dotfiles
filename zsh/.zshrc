# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export PATH="$HOME/.local/bin:$PATH"

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# 자동완성 시 -, _ 구분x
HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# history에서 시간 출력할 거면 사용
# 세가지 형식 가능 "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications, see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

# autosuggestion글씨 색깔 설정
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=110'

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# custom alias
alias vi='nvim'

# source "/home/linuxbrew/.linuxbrew/opt/kube-ps1/share/kube-ps1.sh"
# PS1='$(kube_ps1)'$PS1

export EDITOR=nvim

bindkey -v
KEYTIMEOUT=10
bindkey -M viins "^ " autosuggest-accept
bindkey -M vicmd "^ " autosuggest-accept
bindkey -M vicmd '/' fzf-history-widget

bindkey -M viins "^H" backward-kill-word # ctrl+backspace (ghostty)
bindkey -M viins "^[[8;5u" backward-kill-word # ctrl+backspace (wezterm)

bindkey -M viins -s $'^[[32;2u' ' ' # grep | ~~ 이런거 빠르게 치다보면 shift+space로 눌릴 때 있는데 wezterm에선 ^[[32;2u라서 esc로 인식되는 경우 있는데 방지

# # Home
# bindkey -M viins "^[[H" beginning-of-line
# bindkey -M vicmd "^[[H" beginning-of-line
# bindkey -M viins "^[[1~" beginning-of-line
# bindkey -M vicmd "^[[1~" beginning-of-line
#
# # End
# bindkey -M viins "^[[F" end-of-line
# bindkey -M vicmd "^[[F" end-of-line
# bindkey -M viins "^[[4~" end-of-line
# bindkey -M vicmd "^[[4~" end-of-line
#
# # 터미널vi모드 커서 모양 설정
function zle-keymap-select {
    if [[ $KEYMAP == vicmd ]]; then
        echo -ne "\e[2 q"  # block cursor for normal mode
        VIMODE=1
    else
        echo -ne "\e[6 q"  # bar cursor for insert mode
        VIMODE=0
    fi
    zle reset-prompt
}
zle -N zle-keymap-select

function zle-line-init {
    echo -ne "\e[6 q"  # 시작할 때 bar cursor
    VIMODE=0
    zle reset-prompt
}
zle -N zle-line-init

alias pf='fzf --preview "bat --style=numbers --color=always {}"'

# 전체 하위 디렉토리 포함
previewall() {
    local file
    file=$(find -L . -type f | fzf --preview "bat --style=numbers --color=always {}")
    [[ -n "$file" ]] && nvim "$file"
}

# 현재 디렉토리 자식만 (maxdepth 1)
preview() {
    local file
    file=$(find -L . -maxdepth 1 -type f | fzf --preview "bat --style=numbers --color=always {}")
    [[ -n "$file" ]] && nvim "$file"
}

y2m() { # youtubeToMp3
    url=$(echo "$1" | sed 's/\\//g')
    yt-dlp -x --audio-format mp3 --no-playlist -P "$HOME/Music" "$url"
}

alias blueconnect='bluetoothctl connect 84:5F:04:89:55:82'
alias bluedisconnect='bluetoothctl disconnect 84:5F:04:89:55:82'

# exa
alias ls='eza --color=auto --icons'
alias ll='eza -l -h --icons --git --color=always'
alias la='eza -l -h -a --icons --git --color=always'
alias lsd='eza -l -D --icons --color=always'  # 디렉토리만
alias tree='eza --tree --level=2 --icons --color=always'

alias fm='yazi'

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

alias nvimrc='cd ~/.config/nvim'
alias zshrc='nvim ~/dotfiles/zsh/.zshrc'
alias wezrc='nvim ~/.wezterm.lua'
alias yazirc='nvim ~/.config/yazi/yazi.toml'
alias yazikeyrc='nvim ~/.config/yazi/keymap.toml'
alias swayrc='nvim ~/.config/sway/config'
alias waybarrc='nvim ~/.config/waybar/config.jsonc'
alias bongorc='nvim ~/.config/bongocat/bongocat.conf'
alias makorc='nvim ~/.config/mako/config'
alias swncrc='cd ~/.config/swaync/'
alias ghosttyrc='nvim ~/.config/ghostty/config'
alias mpdrc='nvim ~/.config/mpd/mpd.conf'
alias ncmpcpprc='nvim ~/.config/ncmpcpp/config'
alias zellijrc='nvim ~/.config/zellij/config.kdl'
alias zathurarc='nvim ~/.config/zathura/zathurarc'
alias rofirc='cd ~/.config/rofi'
alias hyprrc='cd ~/.config/hypr'
alias kittyrc='nvim ~/.config/kitty/kitty.conf'
alias sshconfig='nvim ~/.ssh/config'
alias nrc='nvim ~/dotfiles/nixos/configuration.nix'
alias nhrc='nvim ~/dotfiles/nixos/home.nix'
alias nsw='sudo nixos-rebuild switch --flake ~/dotfiles#nixos'

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

alias dnd='dragon-drop'

ssh() {
	local host="$1"
	local password_info=$(sed -n "/Host $host/,/#/p" ~/.ssh/config | sed -n '/#/p' | head -n 1 | sed 's/.*# //')

	if [[ -n "$password_info" ]]; then
        echo -e "🔑 : $password_info"
	fi

	command ssh "$@"
}

sshmount() {
	local host="$1"
	local password_info=$(sed -n "/Host $host/,/#/p" ~/.ssh/config | sed -n '/#/p' | head -n 1 | sed 's/.*# //')

	if [[ -n "$password_info" ]]; then
        echo -e "🔑 : $password_info"
	fi

    local dir="$HOME/mnt/remote-$host"
    mkdir -p "$dir"
    if sshfs "$host:/" "$dir" -o reconnect,ServerAliveInterval=15,ServerAliveCountMax=3; then
        echo "Mounted $host at $dir"
    else
        echo "Failed to mount $host at $dir" >&2
    fi
}

sshumount() {
    local host="$1"
    local dir="$HOME/mnt/remote-$host"
    if fusermount3 -u "$dir"; then
        echo "Unmounted $dir"
    else
        echo "Failed to unmount $dir" >&2
    fi
}

sshmount_home() {
    local host="$1"
    local password_info=$(sed -n "/Host $host/,/#/p" ~/.ssh/config | sed -n '/#/p' | head -n 1 | sed 's/.*# //')

    if [[ -n "$password_info" ]]; then
        echo -e "🔑 : $password_info"
    fi

    local dir="$HOME/mnt/remote-$host"
    mkdir -p "$dir"

    if sshfs "$host:" "$dir" -o reconnect,ServerAliveInterval=15,ServerAliveCountMax=3; then
        echo "Mounted $host at $dir"
    else
        echo "Failed to mount $host at $dir" >&2
    fi
}

cr() { # compile & run
    if [[ $# -lt 1 ]]; then
        print -u2 "usage: cr <file.cpp> [program-args...]"
        return 2
    fi

    local src="$1"
    shift

    if [[ ! -f "$src" ]]; then
        print -u2 "cr: no such file: $src"
        return 2
    fi

    local out="${src:t:r}"
    local safe_src="$src"

    # '-'로 시작할 경우 ./ 붙임
    if [[ "$src" = -* ]]; then
        safe_src="./$src"
    fi

    g++ -O2 --std=c++17 -o "$out" "$safe_src" && "./$out" "$@"
}

alias g="lazygit"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias cdgitroot='cd $(git rev-parse --show-toplevel)'

alias skku-vpn='/usr/local/axgate/axgate_sslvpn_cui'

# mpc
alias mc='mpc clear'
alias mu='mpc update'
alias ma='mpc add'
alias ms='mpc shuffle'
alias mp='mpc play'
alias mn='mpc next'
alias mpr='mpc prev'
alias mt='mpc toggle'

alias dol='nohup dolphin . >/dev/null 2>&1 &'

alias code='code --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-wayland-ime'

tm() {
    termdown "$*" && \
    notify-send -u critical "timer" "time over" && \
    paplay /usr/share/sounds/freedesktop/stereo/alarm-clock-elapsed.oga
}

# ANTLR
export CLASSPATH=".:/usr/local/lib/antlr-complete.jar:$CLASSPATH"
alias antlr4='java -jar /usr/local/lib/antlr-complete.jar'
alias grun='java org.antlr.v4.gui.TestRig'
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/
