{pkgs, ...}: let
  nodeName = "easyeffects_source";
  audioPosition = "FL,FR";
  toggle-mic = pkgs.writeShellApplication {
    name = "toggle-mic";
    text = builtins.readFile ./toggle-mic.sh;
    runtimeInputs = with pkgs; [
      gawk
      pulseaudio
    ];
  };
  toggle-mic-notif-raw = pkgs.writeShellApplication {
    name = "toggle-mic-notif";
    text = builtins.readFile ./toggle-mic-notif.sh;
    runtimeInputs = with pkgs; [
      gawk
      pulseaudio
      pipewire
    ];
  };
  toggle-mic-notif = pkgs.runCommand "toggle-mic-notif" {} ''
    mkdir -p $out/bin $out/share
    cp ${toggle-mic-notif-raw}/bin/toggle-mic-notif $out/bin
    ln -s ${./notification.ogg} $out/share/notification.ogg
  '';
in
  ((import ./virtual-mics.nix) {inherit nodeName audioPosition;})
  // {
    environment.systemPackages = [
      toggle-mic
    ];
    systemd.user = {
      services.mic-switcher-notif = {
        enable = true;
        description = "Mic Switcher notification service";
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${toggle-mic-notif}/bin/toggle-mic-notif";
        };
      };
      timers.mic-switcher-notif = {
        enable = true;
        description = "Mic Switcher notification timer";
        after = ["sound.target"];
        wantedBy = ["default.target"];
        timerConfig = {
          OnBootSec = "10";
          OnUnitActiveSec = "10";
          AccuracySec = "1s";
          Unit = "mic-switcher-notif.service";
        };
      };
    };
  }
