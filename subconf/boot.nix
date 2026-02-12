{ config, pkgs, ... }:

{
  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernelParams = [ "threadirqs" "preempt=full" "nohz_full=all" ];

    kernel.sysctl = {
      "kernel.sysrq" = 1;
    };
    
    supportedFilesystems = [ "bcachefs" ];
    
    extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
    extraModprobeConfig = ''
      options kvm_intel nested=1
      options kvm_intel emulate_invalid_guest_state=0
      options kvm ignore_msrs=1

      options nvidia NVreg_EnablePCIeGen3=1
      options nvidia NVreg_UsePageAttributeTable=1
      options nvidia NVreg_RemapLimit=510
    '';

    binfmt.emulatedSystems = [ "aarch64-linux" ];
  };

  hardware.cpu.intel.updateMicrocode = true;
}
