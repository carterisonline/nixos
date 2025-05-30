{pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    authenticator
    commit
    eartag
    elastic
    errands
    eyedropper
    junction
    metadata-cleaner
    mission-center
    vaults
    wike
  ];
  environment.gnome.excludePackages = with pkgs; [
    atomix
    cheese
    epiphany
    evince
    geary
    gnome-characters
    gnome-console
    gnome-music
    gnome-photos
    gnome-system-monitor
    gnome-terminal
    gnome-text-editor
    gnome-tour
    hitori
    iagno
    tali
    totem
  ];
  programs.dconf.enable = true;
  # prefer Nvidia card on Mutter
  services.udev.extraRules = ''ENV{ID_PATH}=="pci-0000:22:00.0", TAG+="mutter-device-preferred-primary"'';
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome = {
      enable = true;
      extraGSettingsOverridePackages = [pkgs.mutter];
      # I'm not 100% sure what kms-modifiers does but apparently it fixes some issues with Nvidia drivers
      extraGSettingsOverrides = ''
        [org.gnome.mutter]
        experimental-features=['variable-refresh-rate', 'scale-monitor-framebuffer', 'kms-modifiers']
      '';
    };
  };
}
