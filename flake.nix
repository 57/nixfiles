{
  description = "fawn's nixos configuration :3";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: let
    system = "x86_64-linux";
    pkgs   = import nixpkgs { inherit system; config.allowUnfree = true; };
  in {
    # NixOS for this host
    nixosConfigurations.koinu = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; }; # pass inputs to modules if needed
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.users.fawn = import ./home.nix;
          home-manager.backupFileExtension = "backup";
        }
      ];
    };

    # Simple dev shell with common CLI tools
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = with pkgs; [ git nixpkgs-fmt eza bat ripgrep ];
    };
  };
} 