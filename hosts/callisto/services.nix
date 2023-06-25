{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
#Services for x13s battery-sound etc. functionality, relies on firmware
{
  systemd.services.pd-mapper = {
    unitConfig = {
      Requires = "qrtr-ns.service";
      After = "qrtr-ns.service";
    };
    serviceConfig = {
      Restart = "always";
      ExecStart = "${pkgs.pd-mapper}/bin/pd-mapper";
    };
    wantedBy = [
      "multi-user.target"
    ];
  };
  systemd.services.qrtr-ns = {
    serviceConfig = {
      ExecStart = "${pkgs.qrtr}/bin/qrtr-ns -f 1";
      Restart = "always";
    };
    wantedBy = ["multi-user.target"];
  };
}
