{ pkgs, ...}:

{
  boot.plymouth.enable = true;
  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;
  boot.kernelParams = [
    "quiet"
    "splash"
    "boot.shell_on_fail"
    "loglevel=3"
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
    "udev.log_priority=3"
  ];

  systemd.packages = [
    (pkgs.runCommandNoCC "plymouth.conf" {
      preferLocalBuild = true;
      allowSubstitutes = false;
    } ''
      mkdir -p $out/etc/systemd/system/display-manager.service.d/
      cat <<EOF > $out/etc/systemd/system/display-manager.service.d/plymouth.conf
        [Unit]
        Conflicts=plymouth-quit.service
        After=plymouth-quit.service rc-local.service plymouth-start.service systemd-user-sessions.service
        OnFailure=plymouth-quit.service

        [Service]
        ExecStartPost=-/usr/bin/sleep 30
        ExecStartPost=-/usr/bin/plymouth quit --retain-splash
      EOF
    '')
  ];
}
