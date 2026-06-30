{
  nodeName,
  audioPosition,
}: {
  services.pipewire = {
    extraConfig.pipewire = {
      "21-virtual-mics" = {
        "context.modules" = [
          {
            name = "libpipewire-module-loopback";
            args = {
              "node.description" = "Call Mic";
              "capture.props" = {
                "node.name" = "call_mic.capture";
                "audio.position" = audioPosition;
                "target.object" = nodeName;
              };
              "playback.props" = {
                "node.name" = "Call_Mic";
                "node.description" = "Call Mic";
                "media.class" = "Audio/Source";
                "audio.position" = audioPosition;
              };
            };
          }
          {
            name = "libpipewire-module-loopback";
            args = {
              "node.description" = "Game Mic";
              "capture.props" = {
                "node.name" = "game_mic.capture";
                "audio.position" = audioPosition;
                "target.object" = nodeName;
              };
              "playback.props" = {
                "node.name" = "Game_Mic";
                "node.description" = "Game Mic";
                "media.class" = "Audio/Source";
                "audio.position" = audioPosition;
              };
            };
          }
        ];
      };
    };
    wireplumber.extraConfig = {
      "50-game-mic-muted" = {
        "wireplumber.settings" = {};
        "monitor.rules" = [
          {
            matches = [{"node.name" = "Game_Mic";}];
            actions.update-props = {
              "node.mute" = true;
            };
          }
        ];
      };
    };
  };
}
