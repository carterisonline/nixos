{
  environment.sessionVariables = rec {
    SDL_VIDEODRIVER = "wayland";
    MOZ_USE_XINPUT2 = "1";
  };

  security.sudo.extraConfig = ''
    Defaults:root,%wheel env_keep+=WAYLAND_DISPLAY
  '';
}
