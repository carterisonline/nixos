{ stdenv, lib }:

stdenv.mkDerivation {
  pname = "prologue-sound-theme";
  version = "1.0.0";

  src = ./.;

  installPhase = ''
    mkdir -p $out/share/sounds/prologue
    cp index.theme $out/share/sounds/prologue
    cp -r stereo $out/share/sounds/prologue/stereo
  '';

  meta = with lib; {
    description = "Prologue XDG sound theme";
    license = licenses.mit;
    maintainers = [ maintainers.carterisonline ];
    platforms = platforms.linux;
  };
}
