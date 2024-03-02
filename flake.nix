{
  description = "Tag's NixOS configuration";

  inputs = rec {
    # NixOS official package source, using the nixos-23.11 branch here
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs = nixpkgs-stable;
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixd.url = "github:nix-community/nixd";
    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
    alejandra.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    alejandra,
    nixpkgs,
    nixpkgs-unstable,
    nixpkgs-stable,
    home-manager,
    ...
  } @ inputs: {
    nixosConfigurations.aurora-desktop = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        ./mirrors.nix
        ./drives.nix
        ./hardware-configuration.nix
        ./configuration.nix
        ./host/aurora-desktop/core.nix
        ./host/aurora-desktop/boot.nix
        ./host/aurora-desktop/nvidia.nix
        ./host/aurora-desktop/programs.nix
        ./host/base/core.nix
        ./host/base/bluetooth.nix
        ./host/base/graphics.nix
        ./host/base/pipewire.nix
        ./host/base/kde.nix
        {
          nixpkgs.overlays = [
            (final: prev: {
              unstable = import nixpkgs-stable {
                system = system;
                config.allowUnfree = true;
              };
            })
          ];
        }
        {
          nixpkgs.overlays = [
            (final: prev: {
              stable = import nixpkgs-unstable {
                system = system;
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
            ./home/tagho/core.nix
            ./home/tagho/programs.nix
          ];
          home-manager.extraSpecialArgs.inputs = inputs;
        }
        {
          environment.systemPackages = [alejandra.defaultPackage.${system}];
        }
      ];
    };
  };
}
