{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [ ./systemd.nix ./x13s-boot.nix ];
}
