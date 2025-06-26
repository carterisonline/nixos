{
  environment.sessionVariables = {
    MOZ_USE_XINPUT2 = "1";
    WEBKIT_DISABLE_COMPOSITING_MODE = "1";
  };

  security.sudo.extraConfig = ''
    Defaults:root,%wheel env_keep+=WAYLAND_DISPLAY
  '';
}
