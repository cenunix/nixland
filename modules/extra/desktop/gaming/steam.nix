{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.programs;
  device = config.modules.device;
  acceptedTypes = ["laptop" "desktop" "hybrid" "lite" "armlaptop"];
in {
  config = mkIf ((cfg.gaming.steam.enable) && (builtins.elem device.type acceptedTypes)) {
    # enable steam
    steam = {
      enable = true;
      # Open ports in the firewall for Steam Remote Play
      remotePlay.openFirewall = true;
      # Open ports in the firewall for Source Dedicated Server
      dedicatedServer.openFirewall = true;
      # Compatibility tools to install
      # this option is provided by ./gaming/steam.nix
      extraCompatPackages = [
        inputs.nix-gaming.packages.${pkgs.system}.proton-ge
      ];
    };
  };
}
