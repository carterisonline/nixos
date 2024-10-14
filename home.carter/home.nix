{ pkgs, ... }:

{
  imports = [
    ./programs/gnome.nix
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
  
    packages = with pkgs; [ 
      bitwig-studio
      cardinal
      helvum
      lutris
      obsidian
      scrcpy
      yabridge
      yabridgectl
   ];

    username = "carter";
    homeDirectory = "/home/carter";
    stateVersion = "24.05";
  };

  services.flatpak = {
    enableModule = true;
    remotes = {
      "flathub" = "https://dl.flathub.org/repo/flathub.flatpakrepo";
    };
    packages = [
      "flathub:app/com.chatterino.chatterino/x86_64/stable"
      "flathub:app/com.discordapp.Discord/x86_64/stable"
      "flathub:app/org.kde.kalk/x86_64/stable"
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

  programs.kate = {
    enable = true;
    lsp.customServers = {
      nix = {
        command = [ "nil" ];
        url = "https://github.com/oxalica/nil";
        highlightingModeRegex = "^Nix$";
      };
    };
  };
  
  programs.konsole = {
    enable = true;
    defaultProfile = "xf4-modified";
    profiles.xf4-modified = {
      colorScheme = "Breeze";
      extraConfig = {
        General = {
          Environment = "TERM=konsole-direct,COLORTERM=truecolor";
          Parent = "FALLBACK/";
          SemanticHints = 1;
          SemanticInputClick = true;
          SemanticUpDown = true;
        };
      };
    };
  };

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-composite-blur
      obs-pipewire-audio-capture
      obs-shaderfilter
      obs-tuna
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
