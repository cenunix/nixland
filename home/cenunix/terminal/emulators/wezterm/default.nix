{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  programs.wezterm.enable = true;
  home = {
    file.".config/wezterm".source = ./config;
  };
}
