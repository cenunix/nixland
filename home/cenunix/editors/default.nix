{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    ./vscode
    ./helix
  ];
}
