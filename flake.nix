{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    stylix.url = "github:danth/stylix/release-24.05";
    nix-software-center.url = "github:snowfallorg/nix-software-center";
    nix-software-center.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager.url = "github:nix-community/plasma-manager";
    plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
    flatpaks.url = "github:GermanBread/declarative-flatpak/stable-v3";
    flatpaks.inputs.nixpkgs.follows = "nixpkgs";
    nixos-conf-editor.url = "github:snowfallorg/nixos-conf-editor";
    nixos-conf-editor.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, nixpkgs-unstable, stylix, home-manager, plasma-manager, flatpaks, nix-software-center, nixos-conf-editor, ... }@attrs: {
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
              commit = nixpkgs-unstable.legacyPackages.x86_64-linux.commit;
              pragtical = nixpkgs-unstable.legacyPackages.x86_64-linux.pragtical;
              zed = nixpkgs-unstable.legacyPackages.x86_64-linux.zed-editor;
              plasma-panel-colorizer = nixpkgs-unstable.legacyPackages.x86_64-linux.plasma-panel-colorizer;
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
