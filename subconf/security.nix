{ ... }:

{
  users.users.carter = {
    isNormalUser = true;
    home = "/home/carter";
    description = "Carter Reeb";
    extraGroups = [ "audio" "docker" "libvirtd" "wheel" "vboxusers" ];
  };

  security = {
    sudo.enable = false;
    sudo-rs = {
      enable = true;
      execWheelOnly = true;
      extraConfig = ''
        Defaults pwfeedback
      '';
    };
  };
}
