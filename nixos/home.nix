{ config, pkgs, inputs, ... }:

{
  home.username = "simtal";
  home.homeDirectory = "/home/simtal";
  home.stateVersion = "25.11";

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 36;
  };

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    GDK_BACKEND = "wayland,x11";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_WAYLAND_SHELL_INTEGRATION = "xdg-shell";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    SAL_USE_VCLPLUGIN = "qt6";
  };

  services.udiskie = {
    enable = true;
    tray = "auto";
    settings = {
      program_options = {
        automount = true;
        notify = true;
      };
    };
  };

  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-qt;
    defaultCacheTtl = 28800;
    maxCacheTtl = 86400;
    enableExtraSocket = true;
  };

  programs.password-store = {
    enable = true;
    package = pkgs.pass.withExtensions (exts: [ exts.pass-otp ]);
  };

  programs.hyprlock.enable = true;
  services.hypridle.enable = true;

  home.packages = with pkgs; [
    blobdrop
    microsoft-edge google-chrome
    obs-studio
    rclone fuse
    libreoffice-fresh hunspell hunspellDicts.ko_KR
    localsend
    networkmanagerapplet
    kdePackages.dolphin kdePackages.ark kdePackages.kio-extras
    antigravity-fhs
    adwaita-icon-theme hicolor-icon-theme
    btop
    fastfetch
    calcure
    alacritty ghostty kitty
    brightnessctl
    pulseaudio
    pavucontrol
    yt-dlp
    obsidian
    pinentry-qt # ~/.local/bin/otp-notify.sh 에서 필요
    vscode-fhs
    hypridle hyprpaper hyprshot hyprpicker waybar zenity rofi
    # wlogout
    swaynotificationcenter libnotify
    stow
    git
    lua-language-server
    gcc gnumake clang-tools python3
    pkgs.uv
    wget
    wakatime-cli
    neovim neovide
    yazi ffmpegthumbnailer p7zip jq poppler fd trash-cli ripgrep
    chafa resvg exiftool
    zip unzip 
    fzf eza
    clipse wl-clipboard xclip
    mpc ncmpcpp
    sshfs
    wget
  ];

  # TODO:
  home.file.".config/alacritty".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/alacritty";
  home.file.".local/bin".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/bin";
  home.file.".config/clipse".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/clipse";
  home.file.".config/Code".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/Code";
  home.file.".config/ghostty".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/ghostty";
  home.file.".config/hypr".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/hypr";
  home.file.".config/kitty".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/kitty";
  home.file.".config/ncmpcpp".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/ncmpcpp";
  home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nvim";
  home.file.".config/rofi".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/rofi";
  home.file.".config/swaync".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/swaync";
  home.file.".config/waybar".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/waybar";
  home.file.".config/yazi".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/yazi";
  home.file."coding/ps/.clangd".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.clangd";

  services.mpd = {
    enable = true;
    musicDirectory = "${config.home.homeDirectory}/Music";
    playlistDirectory = "${config.home.homeDirectory}/.config/mpd/playlists";
    dbFile = "${config.home.homeDirectory}/.config/mpd/database";
    network.listenAddress = "127.0.0.1";
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "pipewire"
      }
      audio_output {
        type "fifo"
        name "visualizer"
        path "/tmp/mpd.fifo"
        format "44100:16:2"
      }
    '';
  };
  programs.mpv = {
    enable = true;
    config = {
      ao = "pipewire";
      hwdec = "auto-safe";
      vo = "gpu";
      slang = "kor,en";
      save-position-on-quit = true;
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      add_newline = true;
      git_status = {
        conflicted = "✘$count ";
        ahead      = ">$count ";
        behind     = "<$count ";
        diverged   = "<>$count ";
        untracked  = "?$count ";
        staged     = "+$count ";
        modified   = "!$count ";
        renamed    = "»$count ";
        deleted    = "x$count ";
      };
      git_branch = {
        symbol = "git ";
        truncation_symbol = "...";
      };
      aws.symbol = "aws ";
      azure.symbol = "azure ";
      buf.symbol = "buf ";
      bun.symbol = "bun ";
      c.symbol = "C ";
      cpp.symbol = "C++ ";
      cobol.symbol = "cobol ";
      conda.symbol = "conda ";
      container.symbol = "container ";
      crystal.symbol = "cr ";
      cmake.symbol = "cmake ";
      daml.symbol = "daml ";
      dart.symbol = "dart ";
      deno.symbol = "deno ";
      docker_context.symbol = "docker ";
      elixir.symbol = "exs ";
      elm.symbol = "elm ";
      erlang.symbol = "erl ";
      fennel.symbol = "fnl ";
      fortran.symbol = "fortran ";
      fossil_branch = {
        symbol = "fossil ";
        truncation_symbol = "...";
      };
      gcloud.symbol = "gcp ";
      gleam.symbol = "gleam ";
      golang.symbol = "go ";
      gradle.symbol = "gradle ";
      guix_shell.symbol = "guix ";
      haskell.symbol = "haskell ";
      haxe.symbol = "hx ";
      helm.symbol = "helm ";
      hg_branch = {
        symbol = "hg ";
        truncation_symbol = "...";
      };
      hostname.ssh_symbol = "ssh ";
      java.symbol = "java ";
      jobs.symbol = "*";
      julia.symbol = "jl ";
      kotlin.symbol = "kt ";
      kubernetes.symbol = "kubernetes ";
      lua.symbol = "lua ";
      nodejs.symbol = "nodejs ";
      memory_usage.symbol = "memory ";
      meson = {
        symbol = "meson ";
        truncation_symbol = "...";
      };
      mojo.symbol = "mojo ";
      nats.symbol = "nats ";
      netns.symbol = "netns ";
      nim.symbol = "nim ";
      nix_shell.symbol = "nix ";
      ocaml.symbol = "ml ";
      odin.symbol = "odin ";
      opa.symbol = "opa ";
      openstack.symbol = "openstack ";
      package.symbol = "pkg ";
      perl.symbol = "pl ";
      php.symbol = "php ";
      pijul_channel = {
        symbol = "pijul ";
        truncation_symbol = "...";
      };
      pixi.symbol = "pixi ";
      pulumi.symbol = "pulumi ";
      purescript.symbol = "purs ";
      python.symbol = "py ";
      quarto.symbol = "quarto ";
      raku.symbol = "raku ";
      red.symbol = "red ";
      rlang.symbol = "r ";
      ruby.symbol = "rb ";
      rust.symbol = "rs ";
      scala.symbol = "scala ";
      shlvl.symbol = "shlvl ";
      spack.symbol = "spack ";
      solidity.symbol = "solidity ";
      swift.symbol = "swift ";
      typst.symbol = "typst ";
      vagrant.symbol = "vagrant ";
      terraform.symbol = "terraform ";
      xmake.symbol = "xmake ";
      zig.symbol = "zig ";
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
  # programs.pay-respects = {
  #   enable = true;
  #   enableZshIntegration = true;
  # };
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.zsh = {
    enable = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
    };

    shellAliases = {
      # f = "pay-respects zsh --previous";
      cd = "z";
    };
    # TODO:
    initContent = ''
      source ~/dotfiles/zsh/.zshrc
    '';
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "simta1";
        email = "koreajunho0219@gmail.com";
      };
      core = {
        editor = "nvim";
        quotepath = false;
      };
      merge = {
        conflictStyle = "zdiff3";
      };
      init = {
        defaultBranch = "main";
      };
    };
  };
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      navigate = true;
      dark = true;
      side-by-side = true;
    };
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "TwoDark"; # 취향에 맞는 테마 설정 가능
    };
  };
  programs.lazygit = {
    enable = true;
  };

  systemd.user.services.battery-alert = {
    Unit.Description = "Battery alert notification";
    Service = {
      Type = "oneshot";
      ExecStart = "${config.home.homeDirectory}/.local/bin/battery-alert.sh";
    };
  };

  systemd.user.timers.battery-alert = {
    Unit.Description = "Run battery alert script every minute";
    Timer = {
      OnBootSec = "1m";
      OnUnitActiveSec = "1m";
    };
    Install.WantedBy = [ "timers.target" ];
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = [ "microsoft-edge.desktop" ];
    };
  };

  programs.home-manager.enable = true;
}
