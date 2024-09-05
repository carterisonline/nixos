{
  networking = {
    hostName = "nixos";
    networkmanager = {
      enable = true;
      # dns = "none";
      wifi.powersave = true;
    };

    #dhcpcd.extraConfig = "nohook resolv.conf";
    
    # nameservers = [
    #   "127.0.0.1"
    #   "::1"
    # ];

    nftables.enable = true;
    firewall = { 
      enable = true;
      allowedTCPPortRanges = [ 
        { from = 1714; to = 1764; } # KDE Connect
      ];  
      allowedUDPPortRanges = [ 
        { from = 1714; to = 1764; } # KDE Connect
      ];  
    };
  };

  # services.dnscrypt-proxy2 = {
  #   enable = true;
  #   settings = {
  #     ipv6_servers = true;
  #     block_ipv6 = false;

  #     require_dnssec = true;
  #     sources.public-resolvers = {
  #       urls = [
  #         "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
  #         "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
  #       ];
  #       cache_file = "/var/lib/dnscrypt-proxy/public-resolvers.md";
  #       minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
  #     };
  #   };
  # };

  # systemd.services.dnscrypt-proxy2.serviceConfig = {
  #   StateDirectory = "dnscrypt-proxy";
  # };
}
