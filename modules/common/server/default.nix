{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  osConfig,
  ...
}:
with lib; let
  cfg = config.modules.system.server;
in {
  imports = [
    # ./pihole
    ./mediaserver
  ];
  config = mkIf (cfg.enable) {
    age.secrets.mediaserver = {
      file = ../../../secrets/mediaserver.age;
      owner = "cenunix";
      mode = "700";
      group = "users";
    };
  };
}
