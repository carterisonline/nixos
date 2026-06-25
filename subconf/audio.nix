{ ... }:

{
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    extraConfig.pipewire = {
      "10-extra-clock-rates" = {
        "context.properties" = {
          "default.clock.allowed-rates" = [ 44100 48000 ];
        };
      };
      "20-loopback-modules" = {
        "context.modules" = [{
          name = "libpipewire-module-loopback";
          args = {
            "node.description" = "Loopback Sink";
            "capture.props" = {
              "node.name" = "Loopback_Sink";
              "media.class" = "Audio/Sink";
              "audio.position" = "FL,FR";
            };
            "playback.props" = {
              "node.name" = "playback.Loopback_Sink";
              "audio.position" = "AUX0,AUX1";
              "target.object" = "alsa_output.usb-GuangZhou_FiiO_Electronics_Co._Ltd_FiiO_K5_Pro-00.pro-output-0";
              "stream.dont-remix" = true;
              "node.passive" = true;
            };
          };
        }];
      };
    };
  };

  security.pam.loginLimits = [
    { domain = "@audio"; item = "memlock"; type = "-"; value = "unlimited"; }
    { domain = "@audio"; item = "rtprio"; type = "-"; value = "99"; }
    { domain = "@audio"; item = "nofile"; type = "soft"; value = "99999"; }
    { domain = "@audio"; item = "nofile"; type = "hard"; value = "99999"; }
  ];

  services.udev.extraRules = ''
    KERNEL=="rtc0", GROUP="audio"
    KERNEL=="hpet", GROUP="audio"
    DEVPATH=="/devices/virtual/misc/cpu_dma_latency", OWNER="root", GROUP="audio", MODE="0660"
  '';
}
