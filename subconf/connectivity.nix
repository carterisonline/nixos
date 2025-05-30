{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    input.General.ClassicBondedOnly = false;
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
}
