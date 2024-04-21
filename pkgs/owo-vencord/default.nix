{
  buildNpmPackage,
  fetchgit,
  fetchFromGitHub,
  lib,
  esbuild,
  buildGoModule,
  buildWebExtension ? false,
}: let
  version = "owo-2023-12-14";
  gitHash = "beaf164aa88d139ca4d998cbc447936f47b8e171";
in
  buildNpmPackage rec {
    pname = "owo-vencord";
    inherit version;

    src = fetchgit {
      url = "https://git.skye.vg/me/owo-vencord.git";
      rev = gitHash;
      sha256 = "sha256-smXQt+bRz0b+Dh+H1uy04SLUBddXJ4NTrqZ8K++Xn+s=";
    };

    ESBUILD_BINARY_PATH = lib.getExe (esbuild.override {
      buildGoModule = args:
        buildGoModule (args
          // rec {
            version = "0.15.18";
            src = fetchFromGitHub {
              owner = "evanw";
              repo = "esbuild";
              rev = "v${version}";
              hash = "sha256-b9R1ML+pgRg9j2yrkQmBulPuLHYLUQvW+WTyR/Cq6zE=";
            };
            vendorHash = "sha256-+BfxCyg0KkDQpHt/wycy/8CTG6YBA/VJvJFhhzUnSiQ=";
          });
    });

    # Supresses an error about esbuild's version.
    npmRebuildFlags = ["|| true"];

    npmDepsHash = "sha256-WYEdJGoTZgDIpvPjm5gHAHWUdPyQJA3I2xfuruBAJCI=";
    npmFlags = ["--legacy-peer-deps"];
    npmBuildScript =
      if buildWebExtension
      then "buildWeb"
      else "build";
    npmBuildFlags = ["--" "--standalone" "--disable-updater"];

    makeCacheWritable = true;

    prePatch = ''
      cat ${./package-lock.json} > ./package-lock.json
    '';

    VENCORD_HASH = gitHash;
    VENCORD_REMOTE = "me/owo-vencord";

    installPhase =
      if buildWebExtension
      then ''
        cp -r dist/chromium-unpacked/ $out
      ''
      else ''
        cp -r dist/ $out
      '';

    meta = with lib; {
      description = "Vencord web extension";
      homepage = "https://github.com/Vendicated/Vencord";
      license = licenses.gpl3Only;
      maintainers = with maintainers; [FlafyDev NotAShelf Scrumplex];
    };
  }
