{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  config = {
    plugins = {
      toggleterm.enable = true;
    };
  };
}
