{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    ./shared
    ./wayland
  ];
}
