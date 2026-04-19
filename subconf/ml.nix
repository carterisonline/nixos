{ pkgs, ... }:

{
  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda.overrideAttrs (final: prev: { preBuild = ''
      cmake -B build \
        -DCMAKE_SKIP_BUILD_RPATH=ON \
        -DCMAKE_BUILD_WITH_INSTALL_RPATH=ON \
        -DCMAKE_CUDA_ARCHITECTURES='61' \

      cmake --build build -j $NIX_BUILD_CORES
    '';
    });
    acceleration = "cuda";
    syncModels = true;
    loadModels = [ "functiongemma:270m" "qwen2.5-coder:7b" "qwen3.5:4b" "qwen3.5:0.8b" ];
  };
}
