{ inputs, outputs, lib, config, pkgs, ... }: {
  nixpkgs.overlays = [ inputs.nvim-flake.overlays.default ];
  environment.systemPackages = with pkgs; [ nvim-pkg ];
}
