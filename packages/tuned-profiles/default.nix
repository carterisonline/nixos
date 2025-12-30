{ stdenv, lib }:

stdenv.mkDerivation {
  pname = "tuned-profiles";
  version = "1.0.0";

  src = ./.;

  installPhase = ''
    mkdir -p $out
    cp -r scripts $out/bin
  ''; 

  meta = with lib; {
    description = "Tuned Profiles using scx_lavd";
    license = licenses.mit;
    maintainers = [ maintainers.carterisonline ];
    platforms = platforms.linux;
  };
}
