{
  inputs = let
    follow = url: {
      url = url;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  in {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    stylix.url = "github:danth/stylix/release-24.05";
    nix-software-center = follow "github:snowfallorg/nix-software-center";
    home-manager = follow "github:nix-community/home-manager/release-24.05";
    plasma-manager = follow "github:nix-community/plasma-manager";
    flatpaks = follow "github:GermanBread/declarative-flatpak/stable-v3";
  };

  outputs = { nixpkgs, nixpkgs-unstable, stylix, home-manager, plasma-manager, flatpaks, nix-software-center, ... }@attrs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [
        {
          system.stateVersion = "24.05"; # DO NOT CHANGE OR REMOVE
        }
        {
          nixpkgs.overlays = [
            (final: prev: {
              pragtical = nixpkgs-unstable.legacyPackages.x86_64-linux.pragtical;
            })
          ];
        }
        stylix.nixosModules.stylix 
        ./configuration.nix
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.sharedModules = [
            plasma-manager.homeManagerModules.plasma-manager
            flatpaks.homeManagerModules.default
          ];

          home-manager.users.carter = import ./home.carter/home.nix;
        }
      ];
    };
  };
}
