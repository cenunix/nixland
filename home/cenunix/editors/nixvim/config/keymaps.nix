{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  config = {
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };
  };
}
