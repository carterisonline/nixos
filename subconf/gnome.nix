{pkgs, ...}:

let
  nautilus-with-gst-extras = pkgs.nautilus.overrideAttrs (final: prev: {
    buildInputs = prev.buildInputs ++ (with pkgs.gst_all_1; [ gst-libav gst-plugins-good gst-plugins-bad gst-plugins-ugly gst-plugins-rs ]);
  });
in
{
  environment.systemPackages = with pkgs; [
    authenticator
    bazaar
    errands
    eyedropper
    metadata-cleaner
    mission-center
    nautilus-with-gst-extras
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
    gnome-software
    gnome-system-monitor
    gnome-terminal
    gnome-text-editor
    gnome-tour
    hitori
    iagno
    nautilus
    tali
    totem
  ];
  programs.dconf.enable = true;
  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "kitty";
  };
  services.gnome = {
    sushi.enable = true;
  };
  # prefer Nvidia card on Mutter
  services.udev.extraRules = ''ENV{ID_PATH}=="pci-0000:52:00.0", TAG+="mutter-device-preferred-primary"'';
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome = {
    enable = true;
    extraGSettingsOverridePackages = [pkgs.mutter];
    # I'm not 100% sure what kms-modifiers does but apparently it fixes some issues with Nvidia drivers
    extraGSettingsOverrides = ''
      [org.gnome.mutter]
      experimental-features=['kms-modifiers']
    '';
  };
}
