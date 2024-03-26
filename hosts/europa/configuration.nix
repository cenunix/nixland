# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
    ./system.nix
    ../shared
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default
      (final: prev: {
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
      })
      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
    };
  };

  time = {
    timeZone = "America/Los_Angeles";
    hardwareClockInLocalTime = true;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
