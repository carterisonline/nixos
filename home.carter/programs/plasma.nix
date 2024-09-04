{
  enable = true;
  workspace = {
    clickItemTo = "select";
    # cursor.theme = "cz-Viator-Black-Hourglass";
    splashScreen.theme = "None";
  };

  panels = [
    {
      location = "top";
      height = 29;
      widgets = [
        "org.kde.plasma.shutdownorswitch"
        "org.kde.plasma.appmenu"
        "org.kde.plasma.panelspacer"
        {
          digitalClock = {
            date.format.custom = "MMM d";
            date.position = "besideTime";
          };
        }
        "org.kde.plasma.panelspacer"
        "org.kde.plasma.battery"
        "org.kde.plasma.systemtray"
      ];
    }

    {
      location = "right";
      height = 60;
      hiding = "dodgewindows";
      widgets = [{
        iconTasks = {
          launchers = [
            "applications:firefox.desktop"
            "applications:org.kde.dolphin.desktop"
            "applications:org.kde.konsole.desktop"
          ];
        };
      }];
    }
  ];

  hotkeys.commands."launch-konsole" = {
    name = "Launch Konsole";
    key = "F12";
    command = "konsole";
  };

  shortcuts.kwin = {
    "Window Close" = "Meta+Shift+C";
    "Window Maximize" = "Meta+Shift+W";
    "Window Minimize" = "Meta+Shift+S";
  };

  configFile = {
    "kwinrc"."ModifierOnlyShortcuts"."Meta" =
      "org.kde.kglobalaccel,/component/kwin,org.kde.kglobalaccel.Component,invokeShortcut,Overview";

    baloofilerc."Basic Settings"."Indexing-Enabled" = false;
  };
}
