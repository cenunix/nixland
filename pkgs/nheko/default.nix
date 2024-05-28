{ lib, stdenv, fetchFromGitHub, fetchpatch, cmake, asciidoc, pkg-config
, boost179, cmark, coeurl, curl, libevent, libsecret, lmdb, lmdbxx, mtxclient
, nlohmann_json, olm, kdePackages, kdsingleapplication, re2, spdlog
, voipSupport ? true, gst_all_1, libnice }:

stdenv.mkDerivation rec {
  pname = "nheko";
  version = "master";

  src = fetchFromGitHub {
    owner = "Nheko-Reborn";
    repo = "nheko";
    rev = "f3c8fb089aa539599b6df7eff99bc3304af16356";
    hash = "sha256-cv3mdeAAOa+r8eK+Hk6AgCCdbL3qLe+dA2f5E8M1/0g=";
  };

  # patches = [
  #   # The 2 following patches can be removed with the next version bump.
  #   # Backport of https://github.com/Nheko-Reborn/nheko/commit/e89e65dc17020772eb057414b4f0c5d6f4ad98d0.
  #   (fetchpatch {
  #     name = "nheko-fmt10.patch";
  #     url =
  #       "https://gitlab.archlinux.org/archlinux/packaging/packages/nheko/-/raw/1b0d5c9eff6409dfd82953f346546d36c288a4a9/nheko-0.11.3-fix-for-fmt-10.patch";
  #     hash = "sha256-UYqAu2iXT3Bn/MxCtybiJrJLfVMOOVRchWqrGuPfapI=";
  #   })
  #   # https://github.com/Nheko-Reborn/nheko/pull/1552
  #   (fetchpatch {
  #     name = "nheko-fmt10.1.patch";
  #     url =
  #       "https://github.com/Nheko-Reborn/nheko/commit/614facf93c2b5d6118beb822cc542ac53a883c37.patch";
  #     hash = "sha256-rjsQNDfj3Lzbv8ow3qiNozGXQFrtYLhArS6a9JCdgBQ=";
  #   })
  # ];
  #
  nativeBuildInputs = [
    asciidoc
    cmake
    lmdbxx
    pkg-config
    kdsingleapplication
    kdePackages.wrapQtAppsHook
  ];

  buildInputs = [
    boost179
    cmark
    coeurl
    curl
    libevent
    libsecret
    lmdb
    mtxclient
    nlohmann_json
    olm
    kdePackages.full
    # qtgraphicaleffects
    kdePackages.qtimageformats
    kdePackages.qtkeychain
    kdePackages.qtmultimedia
    # kdePackages.qtquickcontrols2
    kdePackages.qttools
    re2
    spdlog
  ] ++ lib.optionals voipSupport (with gst_all_1; [
    gstreamer
    gst-plugins-base
    (gst-plugins-good.override { qt5Support = true; })
    gst-plugins-bad
    libnice
  ]);

  # cmakeFlags = [
  #   "-DCOMPILE_QML=ON" # see https://github.com/Nheko-Reborn/nheko/issues/389
  # ];

  preFixup = lib.optionalString voipSupport ''
    # add gstreamer plugins path to the wrapper
    qtWrapperArgs+=(--prefix GST_PLUGIN_SYSTEM_PATH_1_0 : "$GST_PLUGIN_SYSTEM_PATH_1_0")
  '';

  meta = with lib; {
    description = "Desktop client for the Matrix protocol";
    homepage = "https://github.com/Nheko-Reborn/nheko";
    license = licenses.gpl3Plus;
    mainProgram = "nheko";
    maintainers = with maintainers; [ ekleog fpletz ];
    platforms = platforms.all;
    # Should be fixable if a higher clang version is used, see:
    # https://github.com/NixOS/nixpkgs/pull/85922#issuecomment-619287177
    broken = stdenv.hostPlatform.isDarwin;
  };
}
