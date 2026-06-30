{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    steam-devices-udev-rules
  ];
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  hardware.steam-hardware.enable = true;

  networking = {
    hostName = "nixos";
    nameservers = ["1.1.1.1" "1.0.0.1"];
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

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = ["carter"];
    };
  };

  services.tor = {
    enable = true;
    client.enable = true;
    enableGeoIP = true;
    settings = {
      AutomapHostsOnResolve = true;
      AutomapHostsSuffixes = [".exit" ".onion"];
      DNSPort = 9053;
      ExcludeExitNodes = "{de},{fr}";
      ExcludeNodes = "{de},{fr}";
      Log = "notice syslog";
      SafeLogging = 1;
      Sandbox = true;
      SocksPort = ["9060"];
      StrictNodes = true;
    };
  };

  programs.cdemu = {
    enable = true;
    gui = true;
  };
}
