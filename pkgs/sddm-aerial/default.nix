{
  lib,
  stdenv,
  fetchFromGitHub,
  qtgraphicaleffects,
  themeConfig ? {},
}: let
  customToString = x:
    if builtins.isBool x
    then lib.boolToString x
    else toString x;
  configLines = lib.mapAttrsToList (name: value: lib.nameValuePair name value) themeConfig;
  configureTheme =
    "cp theme.conf theme.conf.orig \n"
    + (lib.concatMapStringsSep "\n"
      (
        configLine:
          "grep -q '^${configLine.name}=' theme.conf || echo '${configLine.name}=' >> \"$1\"\n"
          + "sed -i -e 's/^${configLine.name}=.*$/${configLine.name}=${
            lib.escape ["/" "&" "\\"] (customToString configLine.value)
          }/' theme.conf"
      )
      configLines);
in
  stdenv.mkDerivation {
    pname = "sddm-aerial-theme";
    version = "0.1.5";

    src = fetchFromGitHub {
      owner = "3ximus";
      repo = "aerial-sddm-theme";
      rev = "74fb9d0b2cfc3b63f401606b416e908a71efc447";
      sha256 = "";
    };

    propagatedBuildInputs = [
      qtgraphicaleffects
    ];

    dontWrapQtApps = true;

    preInstall = configureTheme;

    postInstall = ''
      mkdir -p $out/share/sddm/themes/aerial

      mv * $out/share/sddm/themes/aerial/
    '';

    postFixup = ''
      mkdir -p $out/nix-support

      echo ${qtgraphicaleffects} >> $out/nix-support/propagated-user-env-packages
    '';
    meta = with lib; {
      license = licenses.gpl3;
      maintainers = with lib.maintainers; [cenunix];
      homepage = "https://github.com/MarianArlt/sddm-aerial";
      description = "The aerial login theme for SDDM";
      longDescription = ''
      '';
    };
  }
