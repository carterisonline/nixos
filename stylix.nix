pkgs:

{
  enable = true;
  image = ./wallpaper.jpg;
  polarity = "dark";
  cursor.name = "Simp1e-Adw-Dark";
  cursor.package = pkgs.simp1e-cursors;
  cursor.size = 24;
  fonts = {
    sansSerif.name = "Inter";
    sansSerif.package = pkgs.inter;

    monospace.name = "JetBrains Mono";
    monospace.package = pkgs.jetbrains-mono;
  };
}
