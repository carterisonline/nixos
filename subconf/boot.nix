{
  config,
  pkgs,
  ...
}: {
  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod_latest;

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernelParams = ["threadirqs" "preempt=full" "nohz_full=all"];

    kernel.sysctl = {
      "kernel.nmi_watchdog" = 0;
      "vm.dirty_background_bytes" = 67108864;
      "vm.dirty_bytes" = 268435456;
      "vm.dirty_writeback_centisecs" = 1500;
      "vm.vfs_cache_pressure" = 50;
    };

    supportedFilesystems = ["bcachefs"];

    extraModulePackages = with config.boot.kernelPackages; [v4l2loopback];
    extraModprobeConfig = ''
      options kvm_intel nested=1
      options kvm_intel emulate_invalid_guest_state=0
      options kvm ignore_msrs=1

      options nvidia NVreg_EnablePCIeGen3=1
      options nvidia NVreg_UsePageAttributeTable=1
      options nvidia NVreg_RemapLimit=510
    '';

    binfmt.emulatedSystems = ["aarch64-linux"];
  };

  hardware.cpu.intel.updateMicrocode = true;
}
