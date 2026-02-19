{
  environment.sessionVariables = {
    MOZ_USE_XINPUT2 = "1";
    MOZ_DISABLE_RDD_SANDBOX = "1";
    NVD_BACKEND = "direct";
    WEBKIT_DISABLE_COMPOSITING_MODE = "1";
  };

  i18n.defaultLocale = "en_US.UTF-8";

  security.sudo.extraConfig = ''
    Defaults:root,%wheel env_keep+=WAYLAND_DISPLAY
  '';
}
