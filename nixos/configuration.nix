{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager = {
      enable = true;
      # wifi.backend = "iwd"; // SKKU와이파이 연결할수가없음
      wifi.backend = "wpa_supplicant";
  };

  # networking.wireless.iwd = {
  #   enable = true;
  #   settings = {
  #     General = {
  #       ManagementFrameProtection = "disabled";
  #       NetworkConfigurationEnabled = true;
  #     };
  #     Network = {
  #       TlsMinimumProtocolVersion = "TLSv1.0";
  #     };
  #   };
  # };

  # Set your time zone.
  time.timeZone = "Asia/Seoul";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ko_KR.UTF-8";
    LC_IDENTIFICATION = "ko_KR.UTF-8";
    LC_MEASUREMENT = "ko_KR.UTF-8";
    LC_MONETARY = "ko_KR.UTF-8";
    LC_NAME = "ko_KR.UTF-8";
    LC_NUMERIC = "ko_KR.UTF-8";
    LC_PAPER = "ko_KR.UTF-8";
    LC_TELEPHONE = "ko_KR.UTF-8";
    LC_TIME = "ko_KR.UTF-8";
  };

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-hangul
      fcitx5-gtk
    ];
  };

  fonts.packages = with pkgs; [
    nanum
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    baekmuk-ttf
    noto-fonts-color-emoji
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [ 
        pkgs.xdg-desktop-portal-hyprland
        pkgs.xdg-desktop-portal-gtk
    ];
    config.common.default = [ "hyprland" "gtk" ];
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  services.udisks2.enable = true;

  # Enable the GNOME Desktop Environment.
  services.desktopManager.gnome.enable = false;
  services.displayManager.gdm.enable = false;

  services.fprintd.enable = true;
  # security.pam.services.sddm.fprintAuth = true;
  security.pam.services.sudo.fprintAuth = true;
  security.pam.services.hyprlock.fprintAuth = true;

  programs.hyprland = {
      enable = true;
      withUWSM = true;
  };

  programs.zsh.enable = true;

  services.displayManager.sddm = {
    enable = true;
    theme = "sddm-astronaut-theme"; 
    package = pkgs.kdePackages.sddm;
    wayland.enable = true;

    extraPackages = [
      pkgs.kdePackages.qtmultimedia
      pkgs.kdePackages.qtsvg
      pkgs.kdePackages.qtvirtualkeyboard
    ];
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "kr";
    variant = "";
    options = "caps:escape,korean:ralt_hangul,korean:rctrl_hanja";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.simtal = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "simtal";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  programs.fuse.userAllowOther = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    hyprpolkitagent
    sddm-astronaut kdePackages.qtmultimedia kdePackages.qtsvg
  ];

  security.polkit.enable = true;

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
    stdenv.cc.cc.lib
    libgcc.lib
    glib
    zlib
    fuse3
    icu
    nss
    openssl
    curl
    expat
  ];

  environment.etc."security/faillock.conf".text = ''
    deny=5
  '';

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 53317 ];
  networking.firewall.allowedUDPPorts = [ 53317 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
