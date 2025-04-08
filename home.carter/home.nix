{ pkgs, ... }:

{
  imports = [
    ./programs/gnome.nix
    ./programs/helix.nix
  ];

  nixpkgs.config.allowUnfree = true;

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
      bespokesynth
      cardinal
      furnace
      gale
      godot_4-mono
      helvum
      imhex
      lsp-plugins
      lutris
      obsidian
      scrcpy
      vital
      yabridge
      yabridgectl
      zynaddsubfx
   ];
  
    username = "carter";
    homeDirectory = "/home/carter";
    stateVersion = "24.05";
  };

  services.flatpak = {
    enableModule = true;
    remotes = {
      "flathub" = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      "flathub-beta" = "https://dl.flathub.org/beta-repo/flathub-beta.flatpakrepo";
    };
    packages = [
      "flathub:app/com.chatterino.chatterino/x86_64/stable"
      "flathub:app/org.gimp.GIMP/x86_64/stable"
      "flathub:app/org.kde.kdenlive/x86_64/stable"
      "flathub:app/org.nickvision.tubeconverter/x86_64/stable"
      "flathub:app/org.prismlauncher.PrismLauncher/x86_64/stable"
      "flathub:app/net.mkiol.SpeechNote/x86_64/stable"
      "flathub-beta:app/com.discordapp.DiscordCanary/x86_64/beta"
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
      formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
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

  programs.fish = import ./programs/fish.nix pkgs;
  programs.vscode = import ./programs/vscode.nix pkgs;
}
