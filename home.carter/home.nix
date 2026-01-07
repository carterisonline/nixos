{ pkgs, lib, osConfig, ... }:

{
  imports = [
    ./programs/fish.nix
    ./programs/gnome.nix
    ./programs/helix.nix
    ./programs/vscode.nix
  ];

  stylix = ( import ../stylix.nix pkgs ) // {
    targets.vscode.enable = false;
  };
  
  home = {
    file."/home/carter/.gtkrc-2.0".force = lib.mkForce true;

    sessionVariables.NIXPKGS_ALLOW_UNFREE = 1;
  
    packages = with pkgs; [ 
      android-tools
      auto-patchelf
      btop-cuda
      chatterino7
      comma
      doomrunner
      easyeffects
      ff2mpv-rust
      gimp3-with-plugins
      gocryptfs
      goofcord
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
      qpwgraph
      scrcpy
      xarchiver
   ];
  
    username = "carter";
    homeDirectory = "/home/carter";
    stateVersion = "24.05";
  };

  services.flatpak = {
    enable = true;
    uninstallUnmanaged = false;
    remotes = lib.mkOptionDefault [{
      name = "flathub";
      location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
    }];
    packages = [
      "org.kde.kdenlive"
     ];
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

  programs.helix = {
    enable = true;
    settings = {
      editor.cursor-shape = {
        normal = "block";
        insert = "bar";
        select = "underline";
      };
      editor.lsp.display-messages = true;
    };
    languages.language = [{
      name = "nix";
      auto-format = true;
      formatter.command = "${pkgs.nixfmt-classic}/bin/nixfmt";
    }];
  };

  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
    extraConfig = ''
    repaint_delay 4
    input_delay 1
    sync_to_monitor no
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
