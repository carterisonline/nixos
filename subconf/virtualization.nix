{ ... }:

{
    virtualisation = {
      libvirtd.enable = true;
      virtualbox.host ={
        enable = true;
        enableKvm = true;
        enableExtensionPack = true;
        addNetworkInterface = false;
      };
      podman = {
        enable = true;
        dockerCompat = true;
        dockerSocket.enable = true;
      };
    };      
}
