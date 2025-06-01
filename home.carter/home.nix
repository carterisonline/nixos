{ pkgs, lib, ... }:

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
    file."/home/carter/.config/kdeconnect/config" = {
      force = true;
      text = ''
        [General]
        name=NixOS
        customDevices=100.112.114.61
      '';
    };

    sessionVariables.NIXPKGS_ALLOW_UNFREE = 1;
  
    packages = with pkgs; [ 
      android-tools
      auto-patchelf
      bespokesynth
      comma
      easyeffects
      furnace
      frida-tools
      gale
      gamemode
      gocryptfs
      godot_4-mono
      helvum
      imhex
      jetbrains.idea-community-bin
      lsp-plugins
      lutris
      nodePackages.vscode-json-languageserver
      obsidian
      patchelf
      renderdoc
      rpcs3
      scrcpy
      strawberry
      vital
      zynaddsubfx
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
      "com.chatterino.chatterino"
      "org.gimp.GIMP"
      "org.kde.kdenlive"
      "org.nickvision.tubeconverter"
      "org.prismlauncher.PrismLauncher"
      "net.mkiol.SpeechNote"
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

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-composite-blur
      obs-pipewire-audio-capture
      obs-shaderfilter
      obs-tuna
      obs-vkcapture
      wlrobs
    ];
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
