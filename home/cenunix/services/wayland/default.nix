{ inputs
, outputs
, lib
, config
, pkgs
, self
, ...
}: {
  imports = [
    ./waybar
    ./swaync
  ];
}
