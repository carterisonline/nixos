{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./subconf/audio.nix
      ./subconf/boot.nix
      ./subconf/connectivity.nix
      ./subconf/environment.nix
      ./subconf/gnome.nix
      ./subconf/graphics.nix
      ./subconf/plymouth.nix
      ./subconf/runtime.nix
      ./subconf/security.nix
      ./subconf/virtualization.nix
    ];

  time.timeZone = "America/New_York";

  # System Packages should be the minimal set of programs which helps users
  # manage their system, diagnose issues, and get most things done.
  environment.systemPackages = with pkgs; [    
    # Core
    git wget ripgrep fd fzf sd parallel-disk-usage

    # Documentation
    man-pages man-pages-posix

    # Document Management
    helix
    nixd
    alejandra
    
    # Monitoring
    ## GPU
    clinfo
    mesa-demos
    nvtopPackages.full
    vulkan-tools
    ## Hardware
    pciutils
    usbutils
    ## I/O Management
    inotify-tools
    v4l-utils
    wayland-utils
    ## Network
    nmap

    # Multimedia
    gamemode

    # Multiplatform
    winetricks
    wineWow64Packages.stagingFull

    # System Management
    nix-index
    nix-search-cli

    # Terminal
    kitty
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

  programs.nix-ld.enable = true;

  age.secrets.steam-api-key.file = ./secrets/steam-api-key.age;
  programs.steam = {
    enable = true;
    presence = {
      enable = true;
      steamApiKeyFile = config.age.secrets.steam-api-key.path;
      userIds = [ "76561198202701980" ];
    };
  };

  services.flatpak.enable = true;

  stylix = import ./stylix.nix pkgs;
}

