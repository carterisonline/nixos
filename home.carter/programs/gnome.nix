{pkgs, ...}:

let
  gnomeExtensions = with pkgs.gnomeExtensions; [
    blur-my-shell
    dash-to-dock
    gsconnect
    steal-my-focus-window
  ];
in
{
  home.packages = gnomeExtensions;

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/applications/terminal" = {
        exec = "kitty";
      };
      "org/gnome/desktop/interface" = {
        clock-format = "12h";
        clock-show-weekday = true;
        color-scheme = "prefer-dark";
        enable-hot-corners = true;
        font-antialiasing = "rgba";
        gtk-theme = "adw-gtk3";
        icon-theme = "Adwaita";
        scaling-factor = 1;
      };

      "org/gnome/desktop/wm/keybindings" = {
        close = [ "<Super><Shift>c" ];
        maximize = [ "<Super><Shift>w" ];
        minimize = [ "<Super><Shift>s" ];
        move-to-side-e = [ "<Super><Shift>d" ];
        move-to-side-w = [ "<Super><Shift>a" ];
      };

      "org/gnome/desktop/wm/preferences" = {
        button-layout = "appmenu:close";
        resize-with-right-button = true;
        titlebar-font = "Inter Bold 11";
      };

      "org/gnome/settings-daemon/plugins/power" = {
        idle-dim = false;
        sleep-inactive-ac-type = "nothing";
      };

      "org/gnome/settings-daemon/plugins/media-keys" = {
        next = [ "<Ctrl><Alt>Page_Down" ];
        play = [ "<Alt>End" ];
        previous = [ "<Ctrl><Alt>Page_Up" ];
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "F12";
        command = "kitty";
        name = "Launch terminal";
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
        binding = "<Ctrl><Alt>Escape";
        command = "resources";
        name = "Launch resources";
      };      

      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = builtins.map (x: x.extensionUuid) gnomeExtensions;
        favorite-apps = [
          "firefox.desktop"
          "org.gnome.Nautilus.desktop"
          "com.bitwig.BitwigStudio.desktop"
          "org.gnome.Todo.desktop"
        ];
      };

      "org/gnome/shell/extensions/dash-to-dock" = {
        background-color = "rgb(33,15,74)";
        background-opacity = 1.0;
        custom-background-color = true;
        custom-theme-shrink = true;
        dock-position = "RIGHT";
        extend-height = true;
        running-indicator-style = "DOTS";
        transparency-mode = "FIXED";
      };

      "org/gnome/shell/weather" = {
        automatic-location = true;
      };
    };
  };

  gtk = {
    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
    
    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };
}
