{
  curlFull,
  fontconfig,
  freetype,
  libgcc,
  stdenv,
  fetchzip,
  lib,
}:
stdenv.mkDerivation rec {
  pname = "ambirr";
  version = "0.2";

  src = fetchzip {
    url = "https://github.com/odoare/BiRR/releases/download/0.2/BiRR_AmbiRR.0.2.LIN.x64.VST3.zip";
    stripRoot = false;
    hash = "sha256-qnXbUlr9IKLOyqDdfDPcXAkS+0eisItxaolSbr+1E18=";
  };

  buildInputs = [curlFull.out curlFull.out fontconfig.lib freetype.out libgcc.lib fontconfig.lib freetype.out libgcc.lib];

  installPhase = ''
    mkdir -p $out/lib/vst3
    cp -r AmbiRR.vst3 $out/lib/vst3/AmbiRR.vst3
    cp -r BiRR.vst3 $out/lib/vst3/BiRR.vst3
  '';

  postFixup = ''
    patchelf --set-rpath "${lib.makeLibraryPath buildInputs}" $out/lib/vst3/AmbiRR.vst3/Contents/x86_64-linux/AmbiRR.so
    patchelf --set-rpath "${lib.makeLibraryPath buildInputs}" $out/lib/vst3/BiRR.vst3/Contents/x86_64-linux/BiRR.so
  '';
}
