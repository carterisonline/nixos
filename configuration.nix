{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./subconf/audio.nix
      ./subconf/boot.nix
      ./subconf/environment.nix
      ./subconf/gnome.nix
      ./subconf/graphics.nix
      ./subconf/networking.nix
      ./subconf/plymouth.nix
    ];

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.bluetooth.input.General.ClassicBondedOnly = false;

  hardware.logitech.wireless = {
    enable = true;
    enableGraphical  = true;
  };
  
  programs.appimage = {
    enable = true;
    binfmt = true;
  };
  # Only write to the disk every 60s
  fileSystems."/".options = [ "commit=60" ];

  virtualisation.libvirtd.enable = true;
  virtualisation.virtualbox.host.enable = true;
  time.timeZone = "America/New_York";

  users.users.carter = {
    isNormalUser = true;
    home = "/home/carter";
    description = "Carter Reeb";
    extraGroups = [ "audio" "docker" "libvirtd" "wheel" "vboxusers" "wireshark" ];
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
      {
        name = "gamescope";
        nice = -20;
      }
    ];
  };

  services.udev = {
    enable = true;
    # prefer Nvidia card on Mutter
    extraRules = ''
      ENV{ID_PATH}=="pci-0000:22:00.0", TAG+="mutter-device-preferred-primary"
    '';
  };

  environment.systemPackages = with pkgs; [    
    # Core
    git wget p7zip rar ripgrep fd sd parallel-disk-usage gocryptfs

    # Companion
    auto-patchelf
    clinfo
    comma
    frida-tools
    fzf
    gamemode
    glxinfo
    inotify-tools
    nix-index
    nmap
    nvtopPackages.full
    pciutils
    v4l-utils
    vulkan-tools
    wayland-utils

    # Editors
    helix

    # GUI
    libreoffice-qt6-fresh
    mangohud mangojuice vkbasalt vkbasalt-cli renderdoc
    jetbrains.idea-community-bin
    
    # Language Tools
    nil nixfmt-rfc-style nodePackages.vscode-json-languageserver

    # Manpages
    linux-manual man-pages man-pages-posix

    # Multimedia
    easyeffects mpv

    # Multiplatform
    android-tools
    winetricks
    wineWowPackages.stagingFull
  ] ++ (with pkgs.gst_all_1; [
    gstreamer
    gst-plugins-base
    gst-libav
    gst-vaapi
  
    # in order of quality
    gst-plugins-good
    gst-plugins-bad
    gst-plugins-ugly
    gst-plugins-rs
  ]);
      
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

  programs.gamescope = {
    enable = true;
    capSysNice = false;
  };

  programs.nix-ld.enable = true;

  programs.steam = {
    enable = true;
    gamescopeSession = {
      enable = true;
      args = [ "--adaptive-sync" "--hdr-enabled" "--prefer-vk-device" "22:00.0" "-r 240" ];
      env = {
        # from https://steamcommunity.com/app/221410/discussions/0/4700160821455702960/
        ENABLE_GAMESCOPE_WSI = "1";
        GAMESCOPE_NV12_COLORSPACE = "k_EStreamColorspace_BT601";
        __GL_MaxFramesAllowed = "1";
        SRT_URLOPEN_PREFER_STEAM = "1";
        STEAM_GAMESCOPE_HAS_TEARING_SUPPORT = "1";
        STEAM_GAMESCOPE_HDR_SUPPORTED = "1";
        STEAM_GAMESCOPE_NIS_SUPPORTED = "1";
        STEAM_GAMESCOPE_TEARING_SUPPORTED = "1";
        STEAM_GAMESCOPE_VRR_SUPPORTED = "1";
        STEAM_MULTIPLE_XWAYLANDS = "1";
      };
    };
  };

  programs.wireshark.enable = true;

  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };

  stylix = import ./stylix.nix pkgs;
}

