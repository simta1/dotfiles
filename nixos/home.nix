{ config, pkgs, ... }:

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
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };

  # wayland.windowManager.hyprland = {
  #   settings = {
  #       env = [
  #           "XCURSOR_SIZE,36"
  #           "HYPRCURSOR_SIZE,36"
  #       ];
  #   };
  # };
  home.file.".config/hypr".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/hypr";
  home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nvim";

  programs.hyprlock.enable = true;
  services.hypridle.enable = true;

  home.packages = with pkgs; [
    zenity
    calcure
    kitty
    waybar
    hyprpaper
    hyprshot
    neovim
    neovide
    yazi
    ffmpegthumbnailer
    p7zip
    jq
    poppler
    fd
    ripgrep
    fzf
    clipse
    wl-clipboard
    xclip
    mpc
    ncmpcpp
  ];

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
      maven.symbol = "maven ";
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
    initContent = ''
      source ~/dotfiles/zsh/.zshrc
    '';
  };

  programs.home-manager.enable = true;
}
