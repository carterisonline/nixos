{
  enable = true;
  workspace = {
    clickItemTo = "select";
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
            "applications:com.bitwig.BitwigStudio.desktop"
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

  powerdevil.AC.autoSuspend.action = "nothing";

  shortcuts.kwin = {
    "Window Close" = "Meta+Shift+C";
    "Window Maximize" = "Meta+Shift+W";
    "Window Minimize" = "Meta+Shift+S";
  };

  configFile = {
    baloofilerc."Basic Settings".Indexing-Enabled = false;
    kwinrc.ModifierOnlyShortcuts.Meta =
      "org.kde.kglobalaccel,/component/kwin,org.kde.kglobalaccel.Component,invokeShortcut,Overview";
    powerdevilrc."AC/Display".DisplayBrightness = 100;
    powerdevilrc."AC/Display".UseProfileSpecificDisplayBrightness = true;
    powerdevilrc."AC/Performance".PowerProfile = "balanced";
    powerdevilrc."Battery/Display".DisplayBrightness = 25;
    powerdevilrc."Battery/Display".UseProfileSpecificDisplayBrightness = true;
    powerdevilrc."Battery/Performance".PowerProfile = "power-saver";    
  };  
}
