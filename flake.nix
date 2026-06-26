{
  description = "System Flake";

  inputs = {
    # Nix PKGS
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nixpkgs.url = "nixpkgs/nixos-26.05";

    pkgs-local.url = "path:/home/wilko/.local/pkgs";

    musnix = {url = "github:musnix/musnix";};

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    xdg-portal-hyprland = {
      url = "github:hyprwm/xdg-desktop-portal-hyprland";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # Caelestia
    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    caelestia-cli = {
      url = "github:caelestia-dots/cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    hyprland,
    xdg-portal-hyprland,
    caelestia-shell,
    ...
  } @ inputs: let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit system;
        modules = [
          ./system/pc
          ./modules
          inputs.musnix.nixosModules.musnix
          {programs.appimage.binfmt = true;}
        ];
        specialArgs = {inherit inputs;};
      };
    };

    homeConfigurations = {
      wilko = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit inputs hyprland xdg-portal-hyprland;
          pkgs-unstable = import nixpkgs-unstable {
            inherit system;
          };
        };
        modules = [
          ./home/home.nix
          inputs.pkgs-local.homeManagerModules.appimages
          inputs.pkgs-local.homeManagerModules.deb
          caelestia-shell.homeManagerModules.default
        ];
      };
    };
  };
}
