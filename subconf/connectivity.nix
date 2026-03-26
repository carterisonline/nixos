{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    steam-devices-udev-rules
  ];
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  
  hardware.logitech.wireless = {
    enable = true;
    enableGraphical = true;
  };

  hardware.steam-hardware.enable = true;

  networking = {
    hostName = "nixos";
    networkmanager = {
      enable = true;
      wifi.powersave = true;
    };

    firewall.enable = false;
  };

  services.libinput.enable = true;
  services.printing.enable = true;
  services.tailscale.enable = true;
  services.usbmuxd.enable = true;

  services.gnunet = {
    enable = true;
    load = {
      maxNetDownBandwidth = 50000000;
      maxNetUpBandwidth = 50000000;
    };
  };

  services.tor = {
    enable = true;
    client.enable = true;
    enableGeoIP = true;
    settings = {
      AutomapHostsOnResolve = true;
      AutomapHostsSuffixes = [ ".exit" ".onion" ];
      DNSPort = 9053;
      ExcludeExitNodes = "{de},{fr}";
      ExcludeNodes = "{de},{fr}";
      Log = "notice syslog";
      SafeLogging = 1;
      Sandbox = true;
      SocksPort = [ "9060" ];
      StrictNodes = true;
    };
  };

  programs.cdemu = {
    enable = true;
    gui = true;
  };
}
