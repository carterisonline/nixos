{ pkgs, musnix, ... }:

{
  musnix = {
    enable = true;
    rtcqs.enable = true;
    rtirq.enable = true;
    das_watchdog.enable = true;
  };
  services.pipewire = {
     enable = true;
     pulse.enable = true;
  };

  # security.pam.loginLimits = [
  #   { domain = "@audio"; item = "memlock"; type = "-"; value = "unlimited"; }
  #   { domain = "@audio"; item = "rtprio"; type = "-"; value = "99"; }
  #   { domain = "@audio"; item = "nofile"; type = "soft"; value = "99999"; }
  #   { domain = "@audio"; item = "nofile"; type = "hard"; value = "99999"; }
  # ];
}
