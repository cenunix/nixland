{ inputs, outputs, lib, config, pkgs, ... }: {
  imports =
    [ ./env ./games ./misc ./programs ./services ./users ./wayland ./nix.nix ];
}
