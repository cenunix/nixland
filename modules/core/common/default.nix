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
  ];
  age.identityPaths = [
    "/etc/ssh/ssh_host_ed25519_key"
  ];
}
