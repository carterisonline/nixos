{pkgs, ...}: {
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
}
