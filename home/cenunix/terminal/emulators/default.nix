{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./foot
    ./kitty
    ./wezterm
  ];
}
