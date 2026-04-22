{
  description = "System Flake";

  inputs = {
    # Nix PKGS
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nixpkgs.url = "nixpkgs/nixos-25.11";

    musnix  = { url = "github:musnix/musnix"; };

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
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

    # Chaotic
    chaotic = {
      url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, hyprland, xdg-portal-hyprland, caelestia-shell, chaotic, ... } @ inputs:
    let
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
            chaotic.nixosModules.default
            { programs.appimage.binfmt = true; }
          ];
          specialArgs = { inherit inputs; };
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
            ./pkgs/appimages/default.nix
            ./pkgs/deb/default.nix
            caelestia-shell.homeManagerModules.default
          ];
       };
     };
   };
}
