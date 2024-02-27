{
  description = "My NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-23.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    flatpaks.url = "github:gmodena/nix-flatpak"; # unstable branch. Use github:gmodena/nix-flatpak/?ref=<tag> to pin releases.
    nixd.url = "github:nix-community/nixd";
  };

  outputs = { self, nixpkgs, flatpaks, home-manager, ... }@inputs: {
    # Please replace my-nixos with your hostname
    nixosConfigurations.aurora-desktop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
        ./configuration.nix
        ./mirrors.nix
        home-manager.nixosModules.home-manager
        flatpaks.nixosModules.nix-flatpak
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.tagho.imports = [
            flatpaks.homeManagerModules.nix-flatpak
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
