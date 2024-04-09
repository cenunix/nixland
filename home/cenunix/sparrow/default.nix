{ inputs, outputs, lib, config, pkgs, osConfig, ... }:
let
  inherit (lib) mkIf;
  inherit (osConfig) modules;
  inherit (modules) device;
in {
  home.packages = with pkgs;
    mkIf (device.type != "server") [ qbittorrent streamrip lame ];
}
