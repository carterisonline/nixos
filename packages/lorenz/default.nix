{ curlFull, fontconfig, freetype, libgcc, stdenv, fetchzip, lib }:
stdenv.mkDerivation rec {
  pname = "lorenz";
  version = "0.1.1";

  src = fetchzip {
    url = "https://github.com/odoare/Lorenz/releases/download/0.1.1/Lorenz.0.1.1.LIN.x64.VST3.zip";
    hash = "sha256-w6fVsrfr4lgEmZd/PSkLnmNs/nwmc76GSI+hLk5VusM=";
  };

  buildInputs = [ curlFull.out fontconfig.lib freetype.out libgcc.lib ];

  installPhase = ''
    mkdir -p $out
    mkdir -p $out/lib/vst3/Lorenz.vst3
    cp -r Contents $out/lib/vst3/Lorenz.vst3/Contents
  '';

  postFixup = ''
    patchelf --set-rpath "${lib.makeLibraryPath buildInputs}" $out/lib/vst3/Lorenz.vst3/Contents/x86_64-linux/Lorenz.so
  '';
}
