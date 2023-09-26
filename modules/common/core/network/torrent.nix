{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  services.mullvad-vpn.enable = true;
  environment.systemPackages = with pkgs; [
    mullvad-vpn
  ];
}
