{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./security.nix
    ./network.nix
  ];
  age.secrets.spotify-player = {
    file = ../../../secrets/spotify-player.age;
    mode = "777";
  };
  age.identityPaths = [
    "/etc/ssh/ssh_host_ed25519_key"
  ];
}
