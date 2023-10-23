{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    ./wayland
  ];
}
