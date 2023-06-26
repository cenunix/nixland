{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./misc
    ./terminals
    ./shell
    ./tools
  ];
}
