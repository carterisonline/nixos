# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, pkgs, nix-software-center, plasma-manager, flatpaks, musnix, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./subconf/audio.nix
      ./subconf/environment.nix
      ./subconf/graphics.nix
      ./subconf/networking.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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
    pragtical
    nix-software-center.packages.${system}.nix-software-center
    nix-index
    gum
    git
    wget
    nvtopPackages.full
    rar
    p7zip
    mpv
    android-tools
    v4l-utils
    ripgrep fd sd parallel-disk-usage

    # Fonts
    #inter

    # Editors
    helix

    # Nix language tools
    nil
    nixfmt-rfc-style

    # Plasma deps
    kdePackages.bluez-qt
    kdePackages.kdeconnect-kde

    # Deps for plasma info center
    clinfo
    glxinfo
    pciutils
    vulkan-tools
    wayland-utils

    # Wine
    wineWowPackages.stagingFull
    winetricks

    # Python
    python310 python310Packages.pip virtualenv

    # C/Clang
    libclang
  ];
  
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

