{...}: let
  mkCaches = caches: {
    nix.settings.substituters = map (s: "https://" + s) (builtins.attrNames caches);
    nix.settings.trusted-public-keys = (
      map (s: s + "-1:" + (builtins.getAttr s caches)) (builtins.attrNames caches)
    );
  };
in
  mkCaches {
    "cache.nixos.org" = "6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=";
    "nix-community.cachix.org" = "mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=";
    "cuda-maintainers.cachix.org" = "0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E=";
  }
  // {
    nix.settings = {
      experimental-features = ["nix-command" "flakes"];
    };

    nixpkgs.config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "dotnet-sdk-6.0.428"
      ];
      joypixels.acceptLicense = true;
    };
  }
