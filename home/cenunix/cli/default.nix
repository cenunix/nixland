{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./editors
    ./misc
    ./terminals
    ./tools
  ];
}
