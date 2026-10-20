{
  description = "lwilko's System Flake";

  inputs = {
    # Nix PKGS
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nixpkgs.url = "nixpkgs/nixos-26.05";

    musnix = {
      url = "github:musnix/musnix/a84602f";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland
    hyprland = {
      url = "github:hyprwm/Hyprland/v0.56.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    xdg-portal-hyprland = {
      url = "github:hyprwm/xdg-desktop-portal-hyprland/v1.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Caelestia
    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    caelestia-cli = {
      url = "github:caelestia-dots/cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    chaotic = {
      url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-26.05";
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
    chaotic,
    nixvim,
    ...
  } @ inputs: let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    mkHome = hostModule:
      home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit inputs hyprland xdg-portal-hyprland;
          localPkgsPath = "/home/wilko/.local/pkgs";
          pkgs-unstable = import nixpkgs-unstable {
            inherit system;
          };
        };
        modules = [
          ./home-manager/home.nix
          hostModule
          caelestia-shell.homeManagerModules.default
          nixvim.homeModules.nixvim
        ];
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
          inputs.musnix.nixosModules.musnix
          ./nixos/configuration/pc
          ./modules/nixos
          chaotic.nixosModules.default
          {programs.appimage.binfmt = true;}
        ];
      };
    };

    homeConfigurations = {
      wilko = mkHome ./home-manager/hosts/nixos;
      wilko-laptop = mkHome ./home-manager/hosts/laptop;
    };

    formatter.${system} = pkgs.writeShellApplication {
      name = "format-dotfiles";
      runtimeInputs = [pkgs.alejandra];
      text = ''
        alejandra .
      '';
    };
  };
}
