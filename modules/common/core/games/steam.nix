{ inputs, config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.programs;
  device = config.modules.device;
  acceptedTypes = [ "laptop" "desktop" "hybrid" "lite" "armlaptop" ];
  simplegui = pkgs.python3Packages.buildPythonPackage rec {
    pname = "FreeSimpleGui";
    version = "5.1.0";

    src = pkgs.fetchFromGitHub {
      owner = "spyoungtech";
      repo = "FreeSimpleGUI";
      rev = "v${version}";
      sha256 = "sha256-kUHuC5tHEd6SUIbNrad8B2BDGHyHYIfjJqWoLM4r1Bk=";
    };
    propagatedBuildInputs = with python3Packages;
      [ pkgs.python311Packages.tkinter ];

  };
in {
  config = mkIf
    ((cfg.gaming.steam.enable) && (builtins.elem device.type acceptedTypes)) {
      # enable steam
      nixpkgs.config.packageOverrides = pkgs: {
        steam = pkgs.steam.override {
          extraPkgs = pkgs:
            with pkgs; [
              libgdiplus
              keyutils
              libkrb5
              libpng
              libpulseaudio
              libvorbis
              stdenv.cc.cc.lib
              xorg.libXcursor
              xorg.libXi
              xorg.libXinerama
              xorg.libXScrnSaver
              SDL2
              dxvk
              #wemod?
              python3
              tk
              protonup-qt
              python3Packages.pip
              python3Packages.virtualenv
              simplegui
            ];
        };
      };
      programs = {
        steam = {
          enable = true;
          # Open ports in the firewall for Steam Remote Play
          remotePlay.openFirewall = true;
          # Open ports in the firewall for Source Dedicated Server
          dedicatedServer.openFirewall = true;
          # Compatibility tools to install
          # this option is provided by ./gaming/steam.nix
          extraCompatPackages = [ pkgs.proton-ge-bin ];
        };
      };
    };
}
