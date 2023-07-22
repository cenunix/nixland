{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    ./completions.nix
    ./core.nix
    ./plugins
    ./keymaps.nix
  ];
  config = {
    options = {
      number = true;
      relativenumber = true;
      timeoutlen = 0;
    };
  };
}
