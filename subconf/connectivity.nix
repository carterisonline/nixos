{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  
  hardware.logitech.wireless = {
    enable = true;
    enableGraphical = true;
  };

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

  programs.cdemu = {
    enable = true;
    gui = true;
  };
}
