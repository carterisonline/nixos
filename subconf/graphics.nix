{ config, pkgs, ... }:

{
  boot.kernelParams = [ "i915.force_probe=9a49" ];
  environment.sessionVariables.VK_DRIVER_FILES = "/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.x86_64.json:/run/opengl-driver-32/share/vulkan/icd.d/nvidia_icd.i686.json:/run/opengl-driver/share/vulkan/icd.d/intel_icd.x86_64.json:/run/opengl-driver-32/share/vulkan/icd.d/intel_icd.i686.json";
  environment.systemPackages = [ pkgs.cudatoolkit ];
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      vpl-gpu-rt
      intel-media-driver
      libvdpau-va-gl
    ];
    extraPackages32 = with pkgs.driversi686Linux; [
      intel-media-driver
      libvdpau-va-gl
    ];
  };
  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
    prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:22:0:0";
      offload.enable = true;
      allowExternalGpu = true;
    };
  };
  hardware.nvidia-container-toolkit.enable = true;
  services.xserver.videoDrivers = [ "nvidia" "modesetting" "fbdev" "i915" ];
}
