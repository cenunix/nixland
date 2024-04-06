{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [ ./direnv.nix ./shell.nix ./tools.nix ];
}
