# Add your reusable home-manager modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  agenix,
  ...
}: {
  config.home.stateVersion = "23.05";

  # List your module files here
  # my-module = import ./my-module.nix;
  imports = [
    # Hyprland home-manager module
    ./editors
    ./graphical
    ./packages.nix
    ./services
    ./terminal
    ./theme
  ];
}
