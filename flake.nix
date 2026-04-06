{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    stylix.url = "github:danth/stylix/release-25.11";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-alien.url = "github:thiagokokada/nix-alien";
    nix-alien.inputs.nixpkgs.follows = "nixpkgs";
    lsfg-vk-flake.url = "github:pabloaul/lsfg-vk-flake/main";
    lsfg-vk-flake.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, nixpkgs-unstable, stylix, home-manager, nix-alien, lsfg-vk-flake, ... }@attrs:
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
  in
   {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = attrs // { inherit system; };
      
      modules = [
        (pkgOverlay [ "fish" ] nixpkgs-unstable)
        ./settings.nix
        ./configuration.nix
        
        (pkgImport ./packages/prologue-sound-theme/default.nix {})
        (pkgImport ./packages/diagnose/default.nix {})
        (pkgImport ./packages/bitwig-studio/default.nix {})
        (pkgImport ./packages/lorenz/default.nix {})
        (pkgImport ./packages/ambirr/default.nix {})
        (pkgImport ./packages/stringo/default.nix {})
        (pkgImport ./packages/imagein/default.nix {})
        (pkgFromFlake nix-alien)

        lsfg-vk-flake.nixosModules.default                
        
        stylix.nixosModules.stylix
        home-manager.nixosModules.home-manager {
          home-manager = {
            backupFileExtension = "hm-backup";
            useGlobalPkgs = true;
            useUserPackages = true;
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
