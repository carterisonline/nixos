{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    bitwig-studio.url = "github:NixOS/nixpkgs/05bbf675397d5366259409139039af8077d695ce";
    stylix.url = "github:danth/stylix/release-25.11";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.6.0";
    nix-alien.url = "github:thiagokokada/nix-alien";
    nix-alien.inputs.nixpkgs.follows = "nixpkgs";
    nixGL.url = "github:guibou/nixGL";
    nixGL.inputs.nixpkgs.follows = "nixpkgs";
    nix-search-cli.url = "github:peterldowns/nix-search-cli";
    nix-search-cli.inputs.nixpkgs.follows = "nixpkgs";
    isd.url = "github:isd-project/isd";
    isd.inputs.nixpkgs.follows = "nixpkgs";
    lsfg-vk-flake.url = "github:pabloaul/lsfg-vk-flake/main";
    lsfg-vk-flake.inputs.nixpkgs.follows = "nixpkgs";
    millennium.url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";
  };

  outputs = { nixpkgs, nixpkgs-unstable, bitwig-studio, stylix, home-manager, nix-flatpak, nix-alien, nixGL, nix-search-cli, isd, lsfg-vk-flake, millennium, ... }@attrs:
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
      specialArgs = attrs;
      
      modules = [
        (pkgOverlay [ "fish" ] nixpkgs-unstable)
        ./settings.nix
        ./configuration.nix

        ({pkgs, ...}: {
          nixpkgs.overlays = [ millennium.overlays.default ];
          programs.steam = {
            enable = true;
            package = pkgs.millennium-steam;
          };
        })
        
        (pkgImport ./packages/prologue-sound-theme/default.nix {})
        (pkgImport ./packages/diagnose/default.nix {})
        (pkgFromFlake nix-alien)
        (pkgFromFlake nix-search-cli)
        (pkgFromFlake [ "nixGLIntel" "nixVulkanIntel" ] nixGL)
        (pkgFromFlake isd)
        (pkgOverlay [ "bitwig-studio" "yabridge" "yabridgectl" "cardinal" "rnnoise-plugin" ] bitwig-studio)
        (pkgOverlay [ "archipelago" "dolphin-emu" "plugdata" "zed-editor" ] nixpkgs-unstable)
                
        stylix.nixosModules.stylix
        home-manager.nixosModules.home-manager {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            sharedModules = [
              nix-flatpak.homeManagerModules.nix-flatpak
            ];
            users.carter = import ./home.carter/home.nix;
          };
        }

        lsfg-vk-flake.nixosModules.default

        {
          system.stateVersion = "24.05"; # DO NOT CHANGE OR REMOVE
        }
      ];
    };
  };
}
