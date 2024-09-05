{
  programs.ssh.extraConfig = ''
    Host eu.nixbuild.net
      PubkeyAcceptedKeyTypes ssh-ed25519
      ServerAliveInterval 60
      IPQoS throughput
      StrictHostKeyChecking=accept-new
      IdentityFile /home/carter/.ssh/nixbuild-key
  '';

  programs.ssh.knownHosts = {
    nixbuild = {
      hostNames = [ "eu.nixbuild.net" ];
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC9asFvFljBRHCqzR0LucLli6yuDakDmFiJBG651d+km np";
    };
  };
  
  nix.distributedBuilds = true;
  nix.buildMachines = [
    {
      hostName = "eu.nixbuild.net";
      system = "x86_64-linux";
      maxJobs = 100;
      supportedFeatures = [ "benchmark" "big-parallel" ];
    }
  ];
}
