{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    #chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    stylix.url = "github:danth/stylix";
    nix-software-center.url = "github:snowfallorg/nix-software-center";
    nix-software-center.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager.url = "github:nix-community/plasma-manager";
    plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
    flatpaks.url = "github:GermanBread/declarative-flatpak/stable-v3";
    flatpaks.inputs.nixpkgs.follows = "nixpkgs";
    musnix.url = "github:musnix/musnix";
    musnix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, stylix, home-manager, plasma-manager, flatpaks, nix-software-center, musnix, ... }@attrs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [
        {
          system.stateVersion = "24.05"; # DO NOT CHANGE OR REMOVE
        }
        stylix.nixosModules.stylix
        musnix.nixosModules.musnix
        #chaotic.nixosModules.default
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
