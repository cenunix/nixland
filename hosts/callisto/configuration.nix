# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{ inputs
, outputs
, lib
, config
, pkgs
, ...
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
    ./services.nix
  ];
  services.upower.enable = true;
  # nix.buildMachines = [
  #   {
  #     hostName = "europa";
  #     systems = ["x86_64-linux" "aarch64-linux"];
  #     protocol = "ssh-ng";
  #     # if the builder supports building for multiple architectures,
  #     # replace the previous line by, e.g.,
  #     # systems = ["x86_64-linux" "aarch64-linux"];
  #     maxJobs = 4;
  #     speedFactor = 2;
  #     supportedFeatures = ["nixos-test" "benchmark" "big-parallel" "kvm"];
  #     mandatoryFeatures = [];
  #   }
  # ];
  # nix.distributedBuilds = true;
  # # optional, useful when the builder has a faster internet connection than yours
  # nix.extraOptions = ''
  #   builders-use-substitutes = true
  # '';

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
      outputs.overlays.stable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
      (final: prev: {
        qrtr = prev.callPackage ../../pkgs/qrtr.nix { };
        pd-mapper = final.callPackage ../../pkgs/pd-mapper.nix { inherit (final) qrtr; };
        compressFirmwareXz = lib.id;
      })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnsupportedSystem = true;
      allowUnfree = true;
    };
  };

  time = {
    timeZone = "America/Los_Angeles";
    hardwareClockInLocalTime = true;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
