{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./nheko
    ./spotify
    ./webcord
  ];
}
