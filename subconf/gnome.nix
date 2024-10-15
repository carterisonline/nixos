{pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    endeavour
    resources
    wike
  ];
  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-text-editor
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    atomix
    cheese
    epiphany
    evince
    geary
    gnome-characters
    gnome-music
    gnome-system-monitor
    gnome-terminal
    hitori
    iagno
    tali
    totem
  ]);
  programs.dconf.enable = true;
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };
}
