{ pkgs, lib, osConfig, ... }:

{
  imports = [
    ./programs/fish.nix
    ./programs/gnome.nix
    ./programs/helix.nix
    ./programs/vscode.nix
  ];

  stylix = ( import ../stylix.nix pkgs ) // {
    targets = {
      vscode.enable = false;
      helix.enable = false;
    };
  };

  xdg = {
    autostart = {
      enable = true;
      entries = [
        "${pkgs.solaar}/share/applications/solaar.desktop"
        "${pkgs.easyeffects}/share/applications/com.github.wwmm.easyeffects.desktop"
      ];
    };
    terminal-exec = {
      enable = true;
      settings = {
        default = [
          "kitty.desktop"  
        ];
      };
    };
  };
  
  home = {
    file."/home/carter/.gtkrc-2.0".force = lib.mkForce true;

    sessionVariables.NIXPKGS_ALLOW_UNFREE = 1;
  
    packages = with pkgs; [ 
      android-tools
      appimage-run
      archipelago
      auto-patchelf
      btop-cuda
      calf
      cardinal
      carla
      chatterino7
      comma
      dejavu_fonts
      dolphin-emu
      doomrunner
      easyeffects
      ff2mpv-rust
      gale
      gimp3-with-plugins
      gocryptfs
      gzdoom
      imhex
      jetbrains.idea-community-bin
      kdePackages.okular
      krita
      lsp-plugins
      nodePackages.vscode-json-languageserver
      obsidian
      parabolic
      patchelf
      prismlauncher
      protontricks
      qpwgraph
      reaper
      rnnoise-plugin
      ryubing
      scrcpy
      vesktop
      vital
      xarchiver
      yabridge
      yabridgectl
      youtube-music # soon renamed to pear-desktop
   ];
  
    username = "carter";
    homeDirectory = "/home/carter";
    stateVersion = "24.05";
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.git = {
    enable = true;
    settings.user = {
      name = "Carter Reeb";
      email = "me@carteris.online";
    };
  };

  programs.kitty = {
    enable = true;
    enableGitIntegration = true;
    shellIntegration.enableFishIntegration = true;
    extraConfig = ''
    repaint_delay 4
    input_delay 1
    sync_to_monitor no
    confirm_os_window_close 0
    '';
  };

  programs.lutris = {
    enable = true;
    defaultWinePackage = pkgs.proton-ge-bin;
    protonPackages = [ pkgs.proton-ge-bin ];
    runners.linux.settings.system = {
      disable_runtime = true;
      prefix_command = "${pkgs.steam-run}/bin/steam-run";
    };
    runners.wine = {
      settings = {
        system = {
          env = {
            DXVK_CONFIG = "d3d11.cachedDynamicResources=a";
          };
          prefix_command = "env -u DISPLAY";
        };
        runner = {
          battleye = false;
          eac = false;
          esync = false;
          fsr = false;
        };
      };
    };
    steamPackage = osConfig.programs.steam.package;
  };

  programs.mpv = {
    enable = true;
    config = {
      gpu-context = "wayland";
      vo = "gpu-next";
      hwdec = "vaapi";
      ytdl = "yes";
      ytdl-raw-options = "format-sort=vcodec:h264";
    };
    scripts = with pkgs.mpvScripts; [
      uosc # gui
      mpris # global play/pause/progress
      reload # reload on unreliable connections/streams
      thumbfast # fast thumbnail previews
      visualizer # audio visualizers
    ];
    scriptOpts = {
      uosc = {
        disable_elements = "audio_indicator";
      };
      visualizer = {
        height = "9";
        quality = "veryhigh";
      };
    };
  };

  programs.readline = {
    enable = true;
    bindings = {
      "\\C-\\b" = "backward-kill-word";
      "\\C-\\d" = "kill-word";
      "\\C-\\M-\\b" = "backward-kill-line";
      "\\C-\\M-\\d" = "kill-line";
    };
  };

  programs.retroarch = {
    enable = true;
    cores = {
      beetle-psx.enable = true;
      beetle-saturn.enable = true;
      citra.enable = true;
      dolphin.enable = true;
      flycast.enable = true;
      genesis-plus-gx.enable = true;
      melonds.enable = true;
      mgba.enable = true;
      mupen64plus.enable = true;
      nestopia.enable = true;
      pcsx2.enable = true;
      ppsspp.enable = true;
      sameboy.enable = true;
      snes9x.enable = true;
    };
  };
  
  programs.tealdeer = {
    enable = true;
    settings.updates.auto_update = true;
    settings.updates.auto_update_interval_hours = 48;
  };
}
