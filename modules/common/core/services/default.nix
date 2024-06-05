{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [ ./login.nix ./misc.nix ./audio.nix ];
}
