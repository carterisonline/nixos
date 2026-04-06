{ curlFull, fontconfig, freetype, libgcc, stdenv, fetchurl, lib, ouch }:
stdenv.mkDerivation rec {
  pname = "stringo";
  version = "0.2";

  src = fetchurl {
    url = "https://github.com/odoare/StrinGO/releases/download/0.0.2/StrinGO-0.0.2-LIN-VST3.7z";
    hash = "sha256-q5TNUG8Dr69nTN/e55H7sjh859wfRajztrz2tP+lqYQ=";
  };

  unpackPhase = "${ouch}/bin/ouch decompress $src";

  buildInputs = [curlFull.out fontconfig.lib libgcc.lib freetype.out libgcc.lib];

  installPhase = ''
    mkdir -p $out/lib/vst3
    cp -r StrinGO.vst3 $out/lib/vst3/StrinGO.vst3
  '';

  postFixup = ''
    patchelf --set-rpath "${lib.makeLibraryPath buildInputs}" $out/lib/vst3/StrinGO.vst3/Contents/x86_64-linux/StrinGO.so
  '';
}
