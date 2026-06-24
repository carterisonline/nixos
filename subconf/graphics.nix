{ config, pkgs, nixpkgs-unstable, system, ... }:

{
  boot.kernelParams = [ "i915.force_probe=9a49" "i915.enable_guc=3" ];
  environment.sessionVariables.VK_DRIVER_FILES = "/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.json:/run/opengl-driver-32/share/vulkan/icd.d/nvidia_icd.json:/run/opengl-driver/share/vulkan/icd.d/intel_icd.x86_64.json:/run/opengl-driver-32/share/vulkan/icd.d/intel_icd.i686.json";
  environment.systemPackages = [ pkgs.cudatoolkit ];
  fonts.fontconfig.useEmbeddedBitmaps = true;
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
    package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
    prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:52:0:0";
      offload.enable = true;
      allowExternalGpu = true;
    };
  };
  hardware.nvidia-container-toolkit.enable = true;
  services.xserver.videoDrivers = [ "nvidia" "modesetting" "fbdev" "i915" ];
  services.lsfg-vk = {
    enable = true;
    ui.enable = true;
  };
  programs.gamescope = {
    enable = true;
    package = nixpkgs-unstable.legacyPackages.${system}.gamescope;
    args = [
      "--expose-wayland"
      "--backend wayland"
      "--adaptive-sync"
      "--xwayland-count 1"
      "--prefer-vk-device 10de:1b80"
      "--borderless"
      "--rt"
      "-w 1920"
      "-h 1080"
      "-W 1920"
      "-H 1080"
    ];
    env = {
      DXVK_CONFIG="d3d11.cachedDynamicResources=a";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };
  };
}
