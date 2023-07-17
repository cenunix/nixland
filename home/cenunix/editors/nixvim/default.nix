{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  config = import.config;
in {
  nixvim = inputs.nixvim.makeNixvimWithModule {
    inherit pkgs;
    module = config;
  };
}
