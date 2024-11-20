{ inputs, pkgs, ... }:
let nvim-flake-pkg = inputs.nvim-flake.packages.${pkgs.system}.default;
in {
  nixpkgs.overlays = [ inputs.nvim-flake.overlays.default ];
  home.packages = [
    nvim-flake-pkg # pkgs.neovide
  ];
}
