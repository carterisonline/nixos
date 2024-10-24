{ config, pkgs, nix-software-center, nixos-conf-editor, ... }:

let
  prologue-sound-theme = pkgs.callPackage ./packages/prologue-sound-theme/default.nix {};
in
{
  imports =
    [
      ./hardware-configuration.nix
      ./subconf/audio.nix
      ./subconf/environment.nix
      ./subconf/gnome.nix
      ./subconf/graphics.nix
      ./subconf/networking.nix
      ./subconf/plymouth.nix
    ];

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [
      "https://nix-community.cachix.org"
      "https://cuda-maintainers.cachix.org"
      "https://cache.nixos.org/"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
    ];
  };

  nixpkgs.config.allowUnfree = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.bluetooth.input.General.ClassicBondedOnly = false;
  
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  # Disable watchdog. Re-enable this if you get panics
  boot.kernelParams = [ "nmi_watchdog=0" ];
  boot.kernel.sysctl = {
    # Only write to the disk every 60s
    "vm.dirty_writeback_centisecs" = 6000;
  };
  boot.supportedFilesystems = [ "bcachefs" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
  boot.extraModprobeConfig = ''
    options kvm_intel nested=1
    options kvm_intel emulate_invalid_guest_state=0
    options kvm ignore_msrs=1
  '';
  # Only write to the disk every 60s
  fileSystems."/".options = [ "commit=60" ];

  virtualisation.libvirtd.enable = true;

  time.timeZone = "America/New_York";

  users.users.carter = {
    isNormalUser = true;
    home = "/home/carter";
    description = "Carter Reeb";
    extraGroups = [ "audio" "docker" "libvirtd" "wheel" ];
  };

  services.printing.enable = true;
  services.libinput.enable = true;
  services.flatpak.enable = true;

  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
    rulesProvider = pkgs.ananicy-cpp;
    extraRules = [
      {
        # Do what Windows does with Task Manager and make `missioncenter` a top-priority process
        name = "missioncenter";
        nice = -20;
        ioclass = "realtime";
        oom_score_adj = -999;
      }
    ];
  };

  services.udev = {
    enable = true;
    # Enable USB autosuspend for Linux USB Hubs, fingerprint reader and webcam
    extraRules = ''
      ACTION=="add", SUBSYSTEM=="usb", TEST=="power/control", ATTR{idVendor}=="1d6b", ATTR{power/control}="auto"
      ACTION=="add", SUBSYSTEM=="usb", TEST=="power/control", ATTR{idVendor}=="06cb", ATTR{idProduct}=="00bd", ATTR{power/control}="auto"
      ACTION=="add", SUBSYSTEM=="usb", TEST=="power/control", ATTR{idVendor}=="30c9", ATTR{idProduct}=="001b", ATTR{power/control}="auto"
    '';
  };

  environment.systemPackages = with pkgs; [    
    # Core
    git wget p7zip rar ripgrep fd sd parallel-disk-usage

    # Companion
    clinfo
    comma
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
    gamescope
    kitty
    libreoffice-qt6-fresh
    nix-software-center.packages.${system}.nix-software-center
    nixos-conf-editor.packages.${system}.nixos-conf-editor
    
    # Language Tools
    nil nixfmt-rfc-style nodePackages.vscode-json-languageserver

    # Multimedia
    easyeffects mpv prologue-sound-theme

    # Multiplatform
    android-tools
    winetricks
    wineWowPackages.stagingFull
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

  virtualisation.docker = {
    enable = true;
  };

  stylix = import ./stylix.nix pkgs;
}

