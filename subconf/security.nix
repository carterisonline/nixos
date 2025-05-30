{ ... }:

{
  users.users.carter = {
    isNormalUser = true;
    home = "/home/carter";
    description = "Carter Reeb";
    extraGroups = [ "audio" "docker" "libvirtd" "wheel" "vboxusers" "wireshark" ];
  };
}
