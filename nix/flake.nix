{
  description = "My nix configuration for my computers";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    # Declarative tap management for nix-homebrew - pinned so brew
    # installs are reproducible rather than pulling live HEAD each time.
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager, nix-homebrew, ...}@inputs:
  let
        mkDarwin = { hostname, system ? "aarch64-darwin", extraModules ? [ ] }:
        nix-darwin.lib.darwinSystem {
          inherit system;
          specialArgs = { inherit inputs hostname; };
          modules = [
            ./modules/common
            ./modules/darwin
            ./hosts/${hostname}
            home-manager.darwinModules.home-manager
            nix-homebrew.darwinModules.nix-homebrew
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs hostname; };
            }
          ] ++ extraModules;
        };
  in
  {
    darwinConfigurations = {
      harris = mkDarwin {
        hostname = "harris";
        system = "aarch64-darwin";
      };
    };
  };
}