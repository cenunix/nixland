# This file defines overlays
{ inputs, ... }: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs { pkgs = final; };

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {

    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
    # mesa =
    #   (prev.mesa.override
    #     {
    #       galliumDrivers = ["swrast" "freedreno" "zink"];
    #       vulkanDrivers = ["swrast" "freedreno"];
    #       enableGalliumNine = false;
    #       enableOSMesa = false;
    #       enableOpenCL = false;
    #     })
    #   .overrideAttrs (oldAttrs: rec {
    #     mesonFlags =
    #       oldAttrs.mesonFlags
    #       ++ [
    #         "-Dgallium-vdpau=false"
    #         "-Dgallium-va=false"
    #         "-Dandroid-libbacktrace=disabled"
    #       ];
    #     patches =
    #       oldAttrs.patches
    #       ++ [
    #         ../pkgs/mesa-a690/0001-reallocate-on-unshared-export.patch
    #       ];
    #   });
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
