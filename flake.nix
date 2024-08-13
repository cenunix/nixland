{
  description = "NixLand configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-firefox.url =
      "github:nixos/nixpkgs?rev=c4a9c4f8d2f1196e4b08dc8477b2575ee4e3e3be";
    # nixpkgs.url = "github:diniamo/nixpkgs/nvidia-555";
    # nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    # nixpkgs-master.url = "github:nixos/nixpkgs/master";
    # nixpkgs-nvidia.url = "github:diniamo/nixpkgs/nvidia-555";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprland.url =
      "git+https://github.com/hyprwm/Hyprland?ref=refs/tags/v0.42.0&submodules=1";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    # Hyprland workspace overview plugin
    # hyprland-hyprspace = {
    #   url = "github:KZDKM/Hyprspace";
    #   inputs.hyprland.follows = "hyprland";
    # };
    # Hyprland transparency magic
    # hyprland-hyprchroma = {
    #   url = "github:alexhulbert/HyprChroma";
    #   inputs.hyprland.follows = "hyprland";
    # };
    xdg-portal-hyprland.url = "github:hyprwm/xdg-desktop-portal-hyprland";
    # hyprlock = { url = "github:hyprwm/Hyprlock/"; };
    ags.url = "github:Aylur/ags";
    gtk-session-lock = {
      inputs.nixpkgs.follows = "nixpkgs";
      owner = "Cu3PO42";
      repo = "gtk-session-lock";
      type = "github";
    };
    astal-tray = {
      inputs.nixpkgs.follows = "nixpkgs";
      owner = "astal-sh";
      repo = "tray";
      type = "github";
    };
    ts-for-gir-src = {
      flake = false;
      owner = "gjsify";
      repo = "ts-for-gir";
      type = "github";
    };
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    astal.url = "github:Aylur/astal";
    # matugen.url = "github:InioX/matugen?ref=v2.2.0";
    spicetify = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    arrpc = { url = "github:notashelf/arrpc-flake"; };
    # personal neovim flake
    nvim-flake = { url = "github:cenunix/nvim-flake"; };
    # zellij status-bar plugin
    # zjstatus = { url = "github:dj95/zjstatus"; };
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
        let pkgs = nixpkgs.legacyPackages.${system};
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
