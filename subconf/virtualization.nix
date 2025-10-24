{ pkgs, ... }:

{
    virtualisation = {
      libvirtd.enable = true;
      virtualbox.host.enable = true;
      podman = {
        enable = true;
        dockerCompat = true;
        dockerSocket.enable = true;
      };
    };      
}
