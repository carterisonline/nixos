{ pkgs, ... }:

{
  hardware.bluetooth.input.General.ClassicBondedOnly = (builtins.compareVersions pkgs.bluez.version "5.83") != -1;
  users.users.carter = {
    isNormalUser = true;
    home = "/home/carter";
    description = "Carter Reeb";
    extraGroups = [ "audio" "cdrom" "libvirtd" "podman" "wheel" "vboxusers" ];
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
