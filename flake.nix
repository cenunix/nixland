{
  description = "NixLand configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs-firefox.url =
    # "github:nixos/nixpkgs?rev=c4a9c4f8d2f1196e4b08dc8477b2575ee4e3e3be";
    # nixpkgs.url = "github:diniamo/nixpkgs/nvidia-555";
    # nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    # nixpkgs-master.url =
    # "github:nixos/nixpkgs?rev=65f5cbb5f29450dc32a2835aeb8cabfca2fedc09";
    # nixpkgs-nvidia.url = "github:diniamo/nixpkgs/nvidia-555";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags.url = "github:Aylur/ags";

    hyprland.url = "github:hyprwm/hyprland";
    # hyprland.url =
    #   "git+https://github.com/hyprwm/Hyprland?ref=refs/tags/v0.46.2&submodules=1";
    xdg-portal-hyprland.url = "github:hyprwm/xdg-desktop-portal-hyprland";
    # hyprlock = { url = "github:hyprwm/Hyprlock/"; };

    my-shell = { url = "github:cenunix/astal"; };
    # anyrun.url = "github:fufexan/anyrun/launch-prefix";
    walker.url = "github:abenz1267/walker";
    # personal neovim flake
    nvim-flake = { url = "github:cenunix/nvim-flake"; };
    # zellij status-bar plugin
    zjstatus = { url = "github:dj95/zjstatus"; };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
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
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          # in import ./pkgs { inherit pkgs; });
          # in import nixpkgs {
          #   inherit system;
          #   config.allowUnfree = true;
          # } import ./pkgs) { inherit pkgs; };
        in import ./pkgs { inherit pkgs; });

      devShells = forAllSystems (
        # Devshell for bootstrapping Acessible through 'nix develop' or 'nix-shell' (legacy)
        system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in import ./shell.nix { inherit pkgs; });

      overlays = import ./overlays {
        inherit inputs outputs packages;
      }; # Your custom packages and modifications, exported as overlays

      nixosModules = import
        ./modules/nixos; # Reusable nixos modules you might want to export
      homeManagerModules = import
        ./modules/home-manager; # These are usually stuff you would upstream into nixpkgs
      lib = import ./lib { inherit inputs; };

      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = {
        callisto = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs self lib; };
          modules = [ ./hosts/callisto ./modules ];
        };
        europa = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs self lib;
            asztal = self.packages.x86_64-linux.default;
          };
          modules = [ ./hosts/europa ./modules ];
        };
      };
    };
}
