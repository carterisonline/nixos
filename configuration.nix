{ config, pkgs, nix-software-center, plasma-manager, flatpaks, musnix, nixos-conf-editor, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./subconf/audio.nix
      ./subconf/environment.nix
      ./subconf/graphics.nix
      ./subconf/networking.nix
      ./subconf/plymouth.nix
    ];

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [
      "https://nix-community.cachix.org"
      "https://cache.nixos.org/"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  nixpkgs.config.allowUnfree = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

  boot.supportedFilesystems = [ "bcachefs" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];

  time.timeZone = "America/New_York";

  users.users.carter = {
    isNormalUser = true;
    home = "/home/carter";
    description = "Carter Reeb";
    extraGroups = [ "audio" "wheel" ];
  };

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  services.desktopManager.plasma6.enable = true;

  services.printing.enable = true;
  services.libinput.enable = true;
  services.flatpak.enable = true;

  environment.systemPackages = with pkgs; [    
    # Core
    git wget p7zip rar ripgrep fd sd parallel-disk-usage

    # Companion
    clinfo
    glxinfo
    inotify-tools
    nix-index
    nvtopPackages.full
    pciutils
    v4l-utils
    vulkan-tools
    wayland-utils

    # Editors
    helix

    # GUI
    libreoffice-qt6-fresh
    nix-software-center.packages.${system}.nix-software-center
    nixos-conf-editor.packages.${system}.nixos-conf-editor
    
    # Language Tools
    nil nixfmt-rfc-style nodePackages.vscode-json-languageserver

    # Multimedia
    easyeffects mpv

    # Multiplatform
    android-tools
    winetricks
    wineWowPackages.stagingFull
    
    # Plasma deps
    kdePackages.bluez-qt kdePackages.kdeconnect-kde
  ];
  
  # Make Fish the shell, but only in interactive contexts.
  programs.bash = {
    interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';#''
  };

  programs.firefox = {
    enable = true;
    preferences = {
      "widget.use-xdg-desktop-portal.file-picker" = 1;
    };
  };

  programs.steam.enable = true;

  stylix = import ./stylix.nix pkgs;
}

