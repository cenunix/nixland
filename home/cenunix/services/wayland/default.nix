{ inputs
, outputs
, lib
, config
, pkgs
, self
, ...
}: {
  imports = [
    # ./ags
    ./ags2
  ];
}
