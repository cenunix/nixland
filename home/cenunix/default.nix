# Add your reusable home-manager modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{ inputs, outputs, lib, config, pkgs, agenix, self, ... }:
let inherit (lib) mkDefault;
in {
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
  config = {
    home = {
      username = "cenunix";
      homeDirectory = "/home/cenunix";
      extraOutputsToInstall = [ "doc" "devdoc" ];

      #version on config init
      stateVersion = mkDefault "23.05";
    };
    manual = {
      # the docs suck, so we disable them to save space
      html.enable = false;
      json.enable = false;
      manpages.enable = true;
    };
  };
}
