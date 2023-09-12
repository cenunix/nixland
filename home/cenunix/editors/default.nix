{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    ./nvim
    ./vscode
    ./helix
  ];
}
