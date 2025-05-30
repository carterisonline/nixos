{ pkgs, ... }:

{
  # if this sets my max frequency to 3.8Mhz. I am screwed
  powerManagement.cpufreq.max = 3800000;
  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
    rulesProvider = pkgs.ananicy-cpp;
    extraRules = [
      {
        # Do what Windows does with Task Manager and make `missioncenter` a top-priority process
        name = "missioncenter";
        nice = -20;
        ioclass = "realtime";
        oom_score_adj = -999;
      }
      {
        name = "gamescope";
        nice = -20;
      }
    ];
  };
}
