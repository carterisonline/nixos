{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  stylix = ( import ../stylix.nix pkgs ) // {
    targets.vscode.enable = false;
  };
  
  home = {
    file."/home/carter/.gtkrc-2.0".force = true;
  
    packages = with pkgs; [ 
      bitwig-studio
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
    ];
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

  programs.tealdeer = {
    enable = true;
    settings.updates.auto_update = true;
    settings.updates.auto_update_interval_hours = 48;
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

  programs.konsole = {
    enable = true;
    defaultProfile = "xf84-modified";
    profiles.xf84-modified = {
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

  programs.fish = import ./programs/fish.nix pkgs;
  programs.plasma = import ./programs/plasma.nix;
  programs.vscode = import ./programs/vscode.nix pkgs;
}
