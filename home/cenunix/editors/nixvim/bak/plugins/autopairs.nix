{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  config = {
    plugins = {
      nvim-autopairs.enable = true;
    };
  };
}
