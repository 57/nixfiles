{
  description = "fawn's nixos configuration :3";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Claude Desktop (with MCP support) flake
    flake-utils.url = "github:numtide/flake-utils";
    claude-desktop = {
      url = "github:k3d3/claude-desktop-linux-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs = { self, nixpkgs, home-manager, claude-desktop, flake-utils, ... }@inputs: let
    system = "x86_64-linux";

    # Overlay to expose Claude Desktop (MCP-enabled) as a regular package
    overlays = [
      (final: prev: {
        # use the system defined in the enclosing let (x86_64-linux)
        # instead of prev.system (which may be undefined)
        claude-desktop-with-fhs = claude-desktop.packages.${system}.claude-desktop-with-fhs;
      })
    ];

    pkgs = import nixpkgs { inherit system overlays; config.allowUnfree = true; };
  in {
    # NixOS for this host
    nixosConfigurations.koinu = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; }; # pass inputs to modules if needed
      modules = [
        ./configuration.nix
        # Make Claude Desktop overlay available system-wide
        ({ pkgs, ... }: { nixpkgs.overlays = overlays; })
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