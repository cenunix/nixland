{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    ./ags
    ./waybar
  ];
}
