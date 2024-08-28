{ inputs, outputs, lib, config, pkgs, osConfig, ... }:
with lib;
let
  device = osConfig.modules.device;
  pythonDeps = [ pkgs.python312Packages.pybind11 ];
in {
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnsupportedSystem = true;
      permittedInsecurePackages =
        [ "electron-25.9.0" "freeimage-unstable-2021-11-01" ];
      overlays = builtins.attrValues outputs.overlays;
    };
  };
  home.packages = with pkgs;
  # exclude server device type
    [ ] ++ optionals
    # shared packages between all systems
    (builtins.elem device.type [ "desktop" "laptop" "armlaptop" ]) [
      #actual apps
      ttyper
      wofi
      wpa_supplicant_gui
      wofi-bluetooth
      nicotine-plus
      gnome-podcasts
      protonmail-desktop
      kdePackages.tokodon
      ffmpeg
      gdb
      # master-packages.kdePackages.audiotube
      # kdePackages.audiotube
      # kdePackages.qtimageformats
      # ffmpeg-full
      # gst_all_1.gst-libav
      # gst_all_1.gst-plugins-base
      # gst_all_1.gstreamer
      # gst_all_1.gst-vaapi
      # gst_all_1.gst-devtools
      # gst_all_1.gst-editing-services
      # gst_all_1.gst-plugins-good
      # gst_all_1.gst-plugins-bad
      # gst_all_1.gst-plugins-ugly
      # gst_all_1.gst-libav
      # gst_all_1.gst-plugins-base
      # gst_all_1.gstreamer
      # gst_all_1.gst-vaapi
      # gst_all_1.gst-devtools
      # gst_all_1.gst-editing-services
      # gst_all_1.gst-plugins-good
      # gst_all_1.gst-plugins-bad
      # gst_all_1.gst-plugins-ugly
      # vivaldi-ffmpeg-codecs
      # gst_all_1.gstreamermm
      # ffmpeg-full
      #
      (master-packages.kdePackages.audiotube.overrideAttrs (final: prev: rec {
        nativeBuildInputs = [ wrapGAppsHook3 python312Packages.pybind11 ]
          ++ prev.nativeBuildInputs;
        buildInputs = prev.buildInputs ++ [
          kdePackages.qtimageformats
          (master-packages.kdePackages.qtmultimedia.overrideAttrs
            (final: prev: rec {
              cmakeFlags = prev.cmakeFlags
                ++ [ "QT_DEFAULT_MEDIA_BACKEND=gstreamer" ];
            }))
          gst_all_1.gst-libav
          gst_all_1.gst-plugins-base
          gst_all_1.gstreamer
          gst_all_1.gst-vaapi
          gst_all_1.gst-devtools
          gst_all_1.gst-editing-services
          gst_all_1.gst-plugins-good
          gst_all_1.gst-plugins-bad
          gst_all_1.gst-plugins-ugly
          gst_all_1.gstreamermm
        ];
        # ] ++ (with kdePackages; [
        #   qtsvg
        #   extra-cmake-modules
        #   futuresql
        #   kirigami
        #   kirigami-addons
        #   kcoreaddons
        #   ki18n
        #   kcrash
        #   kwindowsystem
        #   purpose
        #   qcoro
        # ]);

        qtWrapperArgs = prev.qtWrapperArgs ++ [''
          --prefix GST_PLUGIN_SYSTEM_PATH_1_0 : ${
            lib.makeLibraryPath [
              gst_all_1.gst-libav
              gst_all_1.gst-plugins-base
              gst_all_1.gstreamer
              gst_all_1.gst-vaapi
              gst_all_1.gst-devtools
              gst_all_1.gst-editing-services
              gst_all_1.gst-plugins-good
              gst_all_1.gst-plugins-bad
              gst_all_1.gst-plugins-ugly
              gst_all_1.gstreamermm
            ]
          }
        ''];

        # propagatedBuildInputs = [
        #   gst_all_1.gst-libav
        #   gst_all_1.gst-plugins-base
        #   gst_all_1.gstreamer
        #   gst_all_1.gst-vaapi
        #   gst_all_1.gst-devtools
        #   gst_all_1.gst-editing-services
        #   gst_all_1.gst-plugins-good
        #   gst_all_1.gst-plugins-bad
        #   gst_all_1.gst-plugins-ugly
        #   gst_all_1.gstreamermm
        # ];
        dontWrapGApps = true;
      }))

      # gpu-screen-recorder-gtk
    ] ++ optionals (builtins.elem device.type [ "desktop" ]) [ ryujinx ]
    ++ optionals (builtins.elem device.type [ "desktop" "laptop" ]) [ ]
    ++ optionals (builtins.elem device.type [ "armlaptop" ]) [
      # additional packages for arm laptop (x13s as of now) machines that use home-manager
    ];
  # xdg.desktopEntries = {
  #   "org.kde.tokodon" = {
  #     name = "Firefox-beta";
  #     genericName = "Mastodon Client";
  #     comment = "Client for the Mastodon";
  #     exec = "env QT_QPA_PLATFORM=xcb ${pkgs.kdePackages.tokodon}/bin/tokodon";
  #     icon = "org.kde.tokodon";
  #     terminal = false;
  #     type = "Application";
  #   };
  # };
}
