{ inputs, outputs, lib, config, pkgs, osConfig, self, ... }:
let
  usr = if (config.modules.system.username == null) then
    "cenunix"
  else
    "${config.modules.system.username}";
in {
  imports = [
    # Import home-manager's NixOS module
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs pkgs; };
    backupFileExtension = "backup";
    users = {
      # Import your home-manager configuration
      ${usr} = ../home/cenunix;
    };
  };
}
