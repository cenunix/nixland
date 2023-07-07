{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  osConfig,
  ...
}: {
  age.secrets.mediaserver = {
    file = ../../secrets/mediaserver.age;
    owner = "cenunix";
    mode = "700";
    group = "users";
  };
  imports = [
    # ./pihole
    ./mediaserver
  ];
}
