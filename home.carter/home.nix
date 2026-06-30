{
  pkgs,
  lib,
  osConfig,
  ...
}: {
  imports = [
    ./programs/fish.nix
    ./programs/gnome.nix
    ./programs/helix.nix
    ./programs/vscode.nix
  ];

  stylix =
    (import ../stylix.nix pkgs)
    // {
      targets = {
        vscode.enable = false;
        helix.enable = false;
      };
    };

  xdg = {
    autostart = {
      enable = true;
      entries = [
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
      btop-cuda
      cardinal
      carla
      chatterino7
      ckan
      dejavu_fonts
      easyeffects
      ff2mpv-rust
      gale
      gocryptfs
      nodejs_latest
      pear-desktop
      protontricks
      qpwgraph
      reaper
      rnnoise-plugin
      scrcpy
      vital
      vscode-json-languageserver
      xarchiver
      yabridge
      yabridgectl
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
    protonPackages = [pkgs.proton-ge-bin];
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

  programs.tealdeer = {
    enable = true;
    settings.updates.auto_update = true;
    settings.updates.auto_update_interval_hours = 48;
  };
}
