# Add your reusable home-manager modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  agenix,
  self,
  ...
}: {
  config.home.stateVersion = "23.05";
  imports = [
    ./editors
    ./graphical
    ./media
    ./services
    ./sparrow
    ./terminal
    ./theme
    ./packages.nix
  ];
}
