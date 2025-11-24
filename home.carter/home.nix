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
    file."/home/carter/.gtkrc-2.0".force = true;

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
      "com.discordapp.Discord"
    ];
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.git = {
    enable = true;
    userName = "Carter Reeb";
    userEmail = "me@carteris.online";
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
    protonPackages = [ pkgs.proton-ge-bin ];
    runners.linux.settings.system = {
      disable_runtime = true;
      prefix_command = "${pkgs.steam-run}/bin/steam-run";
    };
    runners.wine = {
      package = pkgs.proton-ge-bin;
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
  
  programs.tealdeer = {
    enable = true;
    settings.updates.auto_update = true;
    settings.updates.auto_update_interval_hours = 48;
  };
}
