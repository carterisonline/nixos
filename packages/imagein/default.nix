{
  curlFull,
  fontconfig,
  freetype,
  libgcc,
  stdenv,
  fetchurl,
  lib,
  ouch,
}:
stdenv.mkDerivation rec {
  pname = "imagein";
  version = "0.2";

  src = fetchurl {
    url = "https://github.com/odoare/Image-In/releases/download/0.2/Image-In.0.2.LIN.x64.VST3.zip";
    hash = "sha256-MHWT3ToBpS6P0m8DXQD/41yZfwj6H2qPqCJZUb1zabI=";
  };

  unpackPhase = "${ouch}/bin/ouch decompress $src --yes";

  buildInputs = [curlFull.out fontconfig.lib libgcc.lib freetype.out libgcc.lib];

  installPhase = ''
    mkdir -p $out/lib/vst3
    cp -r Image-In.vst3 $out/lib/vst3/Image-In.vst3
  '';

  postFixup = ''
    patchelf --set-rpath "${lib.makeLibraryPath buildInputs}" $out/lib/vst3/Image-In.vst3/Contents/x86_64-linux/Image-In.so
  '';
}
