{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  osConfig,
  ...
}: let
  usr =
    if (config.modules.system.username == null)
    then "cenunix"
    else "${config.modules.system.username}";
in {
  imports = [
    # Import home-manager's NixOS module
    inputs.home-manager.nixosModules.home-manager
    # Hyprland home-manager module
  ];

  home-manager = {
    extraSpecialArgs = {inherit inputs outputs pkgs;};
    users = {
      # Import your home-manager configuration
      ${usr} = ../home/cenunix;
    };
  };
}
