{
  description = "Dylan's darwin system config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, darwin, home-manager, ... }: {
    darwinConfigurations."travesty" = darwin.lib.darwinSystem {
      system = "aarch64-darwin"; # or x86_64-darwin
      modules = [
        ./darwin-configuration.nix
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPackageConfig = true;
          home-manager.users.dylan = import ./home.nix;
        }
      ];
    };
  };
}
