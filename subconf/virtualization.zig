{ pkgs, ... }:

{
    virtualisation = {
      libvirtd.enable = true;
      virtualbox.host.enable = true;
      docker = {
        enable = true;
        enableOnBoot = false;  
      };
    };
}
