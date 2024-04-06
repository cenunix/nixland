{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [ ./common ./shared ./options ./home-manager.nix ];
}
