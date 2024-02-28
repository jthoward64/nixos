{
  description = "My NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-23.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixd.url = "github:nix-community/nixd";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    # Please replace my-nixos with your hostname
    nixosConfigurations.aurora-desktop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
        ./configuration.nix
        ./mirrors.nix
        {
          nixpkgs.overlays = [
            (final: prev: {
              unstable = import inputs.nixpkgs-unstable {
                system = "x86_64-linux";
                config.allowUnfree = true;
              };
            })
          ];
        }
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.tagho.imports = [
            ./home.nix
          ];
          home-manager.extraSpecialArgs.inputs = inputs;
          # Optionally, use home-manager.extraSpecialArgs to pass
          # arguments to home.nix
        }
      ];
    };
  };
}
