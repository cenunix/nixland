{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    # ./system.nix
    # ./schizo.nix
    # ./network.nix
    # ./nix.nix
    ./system
    ./common
    ./users
    ./media
    ./programs
    ./wayland
    ./nix.nix
    # ./cron.nix
    # ./openssh.nix
    # ./blocker.nix
  ];
}
