{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    ./helix
    ./vscode
  ];
}
