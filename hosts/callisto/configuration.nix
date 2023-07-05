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
    ./x13s-firmware.nix
    ./system.nix
    ./services.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

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
      })
      # (final: prev: {
      #   alsa-ucm-conf = prev.callPackage ../../pkgs/alsa-ucm-conf-x13s.nix {};
      #   alsa-lib = final.callPackage ../../pkgs/alsa-lib.nix {inherit (final) alsa-ucm-conf;};
      # })
      # (final: prev: {
      #   alsa-ucm-conf-x13s = final.alsa-ucm-conf.overrideAttrs (oldAttrs: {
      #     src = pkgs.fetchFromGitHub {
      #       owner = "cenunix";
      #       repo = "alsa-ucm-conf";
      #       rev = "c30fda1f8549a18c30fe283b97a6228acb27978d";
      #       # rev = "32b0a008a96a3dd04675659e45a676b639236a98";
      #       # sha256 = "sha256-s/nnGUGFgJ+gpMAOO3hYJ6PrX/qti6U1wyB6PzTiNtM=";
      #       sha256 = "sha256-3jgU9Hg+CzU28VMSRnH2ky0VDpntCHkclK/caSCZYRE=";
      #     };
      #   });
      # })
      # pkgs.alsa-lib.override
      # {
      #   alsa-ucm-conf =
      #     pkgs.callPackage ../../pkgs/alsa-ucm-conf-x13s.nix {};
      # }
      # (final: prev: {
      #   alsa-lib = prev.alsa-lib.override {
      #     alsa-ucm-conf = pkgs.alsa-ucm-conf-x13s;
      #   };
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnsupportedSystem = true;
      allowUnfree = true;
    };
  };

  # nix = {
  #   # This will add each flake input as a registry
  #   # To make nix3 commands consistent with your flake
  #   registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

  #   # This will additionally add your inputs to the system's legacy channels
  #   # Making legacy nix commands consistent as well, awesome!
  #   nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

  #   settings = {
  #     # Enable flakes and new 'nix' command
  #     experimental-features = "nix-command flakes";
  #     # Deduplicate and optimize nix store
  #     auto-optimise-store = false;
  #   };
  # };

  # FIXME: Add the rest of your current configuration

  # TODO: This is just an example, be sure to use whatever bootloader you prefer

  # hardware.enableAllFirmware = true;
  # hardware.firmware = [ pkgs.linux-firmware pkgs.x13s-firmware ];

  # services.xserver.enable = true;
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;
  environment.systemPackages = with pkgs; [
    # libqrtr-glib
    # alsa-ucm-conf
    # (callPackage ../../pkgs/x13s-firmware.nix {})
    (callPackage ../../pkgs/qrtr.nix { })
    (callPackage ../../pkgs/pd-mapper.nix { })
    alsa-ucm-conf-x13s
    # (callPackage ../../pkgs/alsa-ucm-conf-x13s.nix {})
    # (callPackage ../../pkgs/alsa-lib.nix {})

    # (callPackage ../../pkgs/alsa-ucm-conf-x13s.nix {})
    # coreutils-full
  ];

  time = {
    timeZone = "America/Los_Angeles";
    hardwareClockInLocalTime = true;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
