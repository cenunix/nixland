{
  description = "Cenunix NixOS configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland/84ab8d11e8951a6551d1e1bf87796a8589da6d47";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprlock = {
      url = "github:hyprwm/Hyprlock/";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify = {
      url = "github:the-argus/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sss = {
      url = "github:SergioRibera/sss";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    quickshell = {
      url = "github:outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (self) outputs;
    forAllSystems = nixpkgs.lib.genAttrs [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
  in rec {
    packages = forAllSystems (
      # Your custom packages Acessible through 'nix build', 'nix shell', etc
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in
        import ./pkgs {
          inherit pkgs;
        }
    );

    devShells = forAllSystems (
      # Devshell for bootstrapping Acessible through 'nix develop' or 'nix-shell' (legacy)
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in
        import ./shell.nix {inherit pkgs;}
    );

    overlays = import ./overlays {inherit inputs outputs;}; # Your custom packages and modifications, exported as overlays
    nixosModules = import ./modules/nixos; # Reusable nixos modules you might want to export
    homeManagerModules = import ./modules/home-manager; # These are usually stuff you would upstream into nixpkgs
    lib = import ./lib {inherit inputs;};

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      callisto = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs self lib;};
        modules = [
          ./hosts/callisto
          ./modules
        ];
      };
      europa = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs self lib;};
        modules = [
          ./hosts/europa
          ./modules
        ];
      };
    };
  };
}
