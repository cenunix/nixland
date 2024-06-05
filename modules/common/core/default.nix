{ inputs, outputs, lib, config, pkgs, ... }: {
  imports =
    [ ./env ./programs ./services ./users ./wayland ./nix.nix ./bootloaders ./hardware ./network ];
}
