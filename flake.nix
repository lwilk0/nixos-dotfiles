{
  description = "lwilko's System Flake";

  inputs = {
    # Nix PKGS
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nixpkgs.url = "nixpkgs/nixos-26.05";

    pkgs-local.url = "path:/home/wilko/.local/pkgs";

    musnix = {url = "github:musnix/musnix/a84602f";};

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland
    hyprland = {
      url = "github:hyprwm/Hyprland/v0.46.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    xdg-portal-hyprland = {
      url = "github:hyprwm/xdg-desktop-portal-hyprland/v1.3.8";
      inputs.nixpkgs.follows = "nixpkgs";
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

    # Chaotic Nyx
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    hyprland,
    xdg-portal-hyprland,
    caelestia-shell,
    chaotic,
    ...
  } @ inputs: let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit pkgs;
        specialArgs = {
          inherit inputs;
          pkgs-unstable = import nixpkgs-unstable {
            inherit system;
          };
        };
        modules = [
          ./nixos/configuration
          ./modules/nixos
          inputs.musnix.nixosModules.musnix
          chaotic.nixosModules.default
          {programs.appimage.binfmt = true;}
        ];
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
          ./home-manager/home.nix
          inputs.pkgs-local.homeManagerModules.appimages
          inputs.pkgs-local.homeManagerModules.deb
          caelestia-shell.homeManagerModules.default
        ];
      };
    };
  };
}
