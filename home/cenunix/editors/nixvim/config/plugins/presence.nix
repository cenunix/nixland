{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  config = {
    plugins = {
      presence-nvim = {
        enable = true;
      };
    };
  };
}
