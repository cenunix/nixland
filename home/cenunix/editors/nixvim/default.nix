{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  nvim = inputs.nixvim.legacyPackages."${pkgs.system}".makeNixvimWithModule {
    inherit pkgs;
    module = import ./config;
  };
in {
  home.packages = [
    nvim
    # Golang stuff
    pkgs.go
    pkgs.gofumpt
    pkgs.gotools
    pkgs.ripgrep
  ];
}
