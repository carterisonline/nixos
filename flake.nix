{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    bitwig-studio.url = "github:NixOS/nixpkgs/05bbf675397d5366259409139039af8077d695ce";
    
    stylix.url = "github:danth/stylix/release-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    flatpaks.url = "github:GermanBread/declarative-flatpak/stable-v3";
    flatpaks.inputs.nixpkgs.follows = "nixpkgs";
    nix-alien.url = "github:thiagokokada/nix-alien";
    nix-alien.inputs.nixpkgs.follows = "nixpkgs";
    nixGL.url = "github:guibou/nixGL";
    nixGL.inputs.nixpkgs.follows = "nixpkgs";
    umu.url = "github:Open-Wine-Components/umu-launcher?dir=packaging/nix";
    umu.inputs.nixpkgs.follows = "nixpkgs";
    nix-search-cli.url = "github:peterldowns/nix-search-cli";
    nix-search-cli.inputs.nixpkgs.follows = "nixpkgs";
    isd.url = "github:isd-project/isd";
    isd.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, nixpkgs-unstable, bitwig-studio, stylix, home-manager, flatpaks, nix-alien, nixGL, umu, nix-search-cli, isd, ... }@attrs:
  let
    system = "x86_64-linux";
    pkgUse = x: { environment.systemPackages = x; };
    pkgImport = path: opts: { pkgs, ... }: pkgUse [ (pkgs.callPackage path opts) ];
    pkgFromFlake = x: if (builtins.isList x)
      then (y: pkgUse (map (z: y.packages.${system}.${z}) x))
      else pkgUse [ x.packages.${system}.default ];
    pkgOverlay = x: repo: { pkgs, ... }: ( (pkgUse (map (y: pkgs.${y}) x)) // {
      nixpkgs.overlays = [
        (final: prev: builtins.listToAttrs (map (y: { name = y; value = repo.legacyPackages.${system}.${y};}) x))
      ];
    });

    umux = umu.packages.${system}.umu.override {
      version = umu.shortRev;
      truststore = true;
    };
  in
   {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = attrs;
      
      modules = [
        (pkgOverlay [ "fish" ] nixpkgs-unstable)
        ./settings.nix
        ./configuration.nix
        
        (pkgUse [ umux ])
        (pkgImport ./packages/prologue-sound-theme/default.nix {})
        (pkgImport ./packages/diagnose/default.nix {})
        (pkgFromFlake nix-alien)
        (pkgFromFlake nix-search-cli)
        (pkgFromFlake [ "nixGLIntel" "nixVulkanIntel" ] nixGL)
        (pkgFromFlake isd)
        (pkgOverlay [ "bitwig-studio" ] bitwig-studio)
        (pkgOverlay [ "archipelago" "dolphin-emu" "plugdata" "zed-editor" ] nixpkgs-unstable)
                
        stylix.nixosModules.stylix
        home-manager.nixosModules.home-manager {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            sharedModules = [
              flatpaks.homeManagerModules.default
            ];
            users.carter = import ./home.carter/home.nix;
          };
        }

        {
          system.stateVersion = "24.05"; # DO NOT CHANGE OR REMOVE
        }
      ];
    };
  };
}
