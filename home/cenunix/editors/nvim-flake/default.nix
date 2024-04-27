{ inputs, outputs, lib, config, pkgs, ... }: {
  nixpkgs.overlays = [ <nvim-flake>.overlays.default ];
  environment.systemPackages = with pkgs; [ nvim-pkg ];
}
