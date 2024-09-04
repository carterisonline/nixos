{ ... }:

{
  networking = {
    hostName = "nixos";
    networkmanager = {
      enable = true;
      dns = "none";
      wifi.powersave = true;
    };

    dhcpcd.extraConfig = "nohook resolv.conf";
    
    nameservers = [
      # "194.242.2.4"
      # "194.242.2.3"
      # "194.242.2.2"
      # "2a97:e340::4"
      # "2a07:e340::3"
      # "2a07:e340::2"
      "127.0.0.1"
      "::1"
    ];
  };

  services.dnscrypt-proxy2 = {
    enable = true;
    settings = {
      ipv6_servers = true;
      block_ipv6 = false;

      require_dnssec = true;
      sources.public-resolvers = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
        ];
        cache_file = "/var/lib/dnscrypt-proxy/public-resolvers.md";
        minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
      };
    };
  };

  systemd.services.dnscrypt-proxy2.serviceConfig = {
    StateDirectory = "dnscrypt-proxy";
  };
}
