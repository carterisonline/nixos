{ pkgs, musnix, ... }:

{
  hardware.pulseaudio.enable = false;
  services.pipewire = {
     enable = true;
     pulse.enable = true;
     jack.enable = true;
  };

  security.pam.loginLimits = [
    { domain = "@audio"; item = "memlock"; type = "-"; value = "unlimited"; }
    { domain = "@audio"; item = "rtprio"; type = "-"; value = "99"; }
    { domain = "@audio"; item = "nofile"; type = "soft"; value = "99999"; }
    { domain = "@audio"; item = "nofile"; type = "hard"; value = "99999"; }
  ];
}
