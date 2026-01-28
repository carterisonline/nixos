pkgs:

{
  enable = true;
  image = ./wallpaper.jpg;
  polarity = "dark";
  cursor.name = "Simp1e-Adw-Dark";
  cursor.package = pkgs.simp1e-cursors;
  cursor.size = 24;
  fonts = with pkgs; {
    emoji.name = "JoyPixels";
    emoji.package = joypixels;
    
    sansSerif.name = "Inter";
    sansSerif.package = inter;

    serif.name = "Libre Baskerville";
    serif.package = libre-baskerville;

    monospace.name = "JetBrains Mono";
    monospace.package = jetbrains-mono;
  };
}
