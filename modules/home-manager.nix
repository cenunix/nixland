{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  osConfig,
  ...
}: {
  imports = [
    # Import home-manager's NixOS module
    inputs.home-manager.nixosModules.home-manager
    # Hyprland home-manager module
  ];

  home-manager = {
    extraSpecialArgs = {inherit inputs outputs pkgs;};
    users = {
      # Import your home-manager configuration
      cenunix = import ../home/cenunix;
    };
  };
}
