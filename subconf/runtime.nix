{ pkgs, ... }:

let
  tuned-profiles = pkgs.callPackage ../packages/tuned-profiles/default.nix {};
in
{
  hardware.block.scheduler = {
    "mmcblk[0-9]*" = "mq-deadline";
    "nvme[0-9]*" = "kyber";
  };
  # if this sets my max frequency to 3.8Mhz. I am screwed
  powerManagement.cpufreq.max = 3800000;
  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
    rulesProvider = pkgs.ananicy-rules-cachyos;
    extraRules = [
      {
        # Do what Windows does with Task Manager and make `missioncenter` a top-priority process
        name = "missioncenter";
        nice = -20;
        ioclass = "realtime";
        oom_score_adj = -999;
      }
    ];
  };
  services.scx = {
    enable = true;
    scheduler = "scx_lavd";
    extraArgs = [
      "--enable-cpu-bw"
    ];
  };
  # services.power-profiles-daemon.enable = false;
  # services.tuned = {
  #   enable = true;
  #   settings = {
  #     profile_dirs = "/etc/tuned/profiles,${tuned-profiles}";
  #   };
  #   ppdSupport = true;
  #   ppdSettings.profiles = {
  #     balanced = "balanced";
  #     performance = "performance";
  #     power-saver = "powersave";
  #   };
  #   profiles = {
  #     powersave = {
  #       script = {
  #         type = "script";
  #         script = "${tuned-profiles}/bin/tuned-powersave";
  #       };
  #     };
  #     balanced = {
  #       script = {
  #         type = "script";
  #         script = "${tuned-profiles}/bin/tuned-balanced";
  #       };
  #     };
  #     performance = {
  #       script = {
  #         type = "script";
  #         script = "${tuned-profiles}/bin/tuned-performance";
  #       };
  #     };
  #   };
  # };
}
