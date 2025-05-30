{
  networking = {
    hostName = "nixos";
    networkmanager = {
      enable = true;
      wifi.powersave = true;
    };

    firewall.enable = false;
  };

  services.tailscale.enable = true;
}
