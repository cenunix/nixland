{ inputs, outputs, lib, config, pkgs, osConfig, self, ... }:
let arRPC = inputs.arrpc.packages.${pkgs.system}.arrpc;
in {
  systemd.user.services = {
    arRPC = {
      Unit.PartOf = [ "graphical-session.target" ];
      Unit.After = [ "graphical-session.target" ];
      Install.WantedBy = [ "graphical-session.target" ];

      Unit.Description =
        "Discord Rich Presence for browsers, and some custom clients";
      Service = {
        ExecStart = "${lib.getExe arRPC}";
        Restart = "always";
      };
    };
  };
}
