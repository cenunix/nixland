{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
 final: prev: {
   xwayland = let
    xorgproto = prev.xorg.xorgproto.overrideAttrs (oldAttrs: {patches = oldAttrs.patches ++ [./59.patch];});
    wayland-protocols =
      prev.wayland-protocols.overrideAttrs
      (oldAttrs: {patches = [./90.patch];});
    xwayland' = prev.xwayland.override {inherit xorgproto wayland-protocols;};
  in
    xwayland'.overrideAttrs (oldAttrs: {
      src = prev.fetchurl {
        url = "https://gitlab.freedesktop.org/ekurzinger/xserver/-/archive/explicit-sync/xserver-explicit-sync.tar.gz";
        sha256 = "sha256-OFLWmhbA8OTAzGiLF0ZpEPMrcUkkKbji9v3NPe+WHHM=";
      };

      depsBuildBuild = oldAttrs.depsBuildBuild ++ [xorgproto wayland-protocols];

      buildInputs = oldAttrs.buildInputs ++ [prev.udev prev.xorg.libpciaccess];
    });

 };
}
