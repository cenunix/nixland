{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    ./env
    ./programs
    ./services
    ./users
    ./wayland/services.nix
    ./wayland/xdg-portals.nix
    ./nix.nix
    ./bootloaders
    ./hardware
    ./network
  ];
}
