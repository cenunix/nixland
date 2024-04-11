{ lib, stdenvNoCC, pkgs, fetchFromGitHub, pythcat, fetchpatch, gtk3
, colloid-gtk-theme, gnome-themes-extra, gtk-engine-murrine, python3, sassc
, nix-update-script, accents ? [ "blue" ], size ? "standard", tweaks ? [ ]
, variant ? "frappe" }:
let
  validAccents = [
    "blue"
    "flamingo"
    "green"
    "lavender"
    "maroon"
    "mauve"
    "peach"
    "pink"
    "red"
    "rosewater"
    "sapphire"
    "sky"
    "teal"
    "yellow"
  ];
  validSizes = [ "standard" "compact" ];
  validTweaks = [ "black" "rimless" "normal" "float" ];
  validVariants = [ "latte" "frappe" "macchiato" "mocha" ];

  pname = "catppuccin-gtk";

in lib.checkListOfEnum "${pname}: theme accent" validAccents accents
lib.checkListOfEnum "${pname}: color variant" validVariants [ variant ]
lib.checkListOfEnum "${pname}: size variant" validSizes [ size ]
lib.checkListOfEnum "${pname}: tweaks" validTweaks tweaks

stdenvNoCC.mkDerivation rec {
  inherit pname;
  version = "0.7.2";

  src = fetchFromGitHub {
    owner = "cenunix";
    repo = "gtk";
    rev = "edef76faba00f1f8bd8311fc487f0f0b2670dd0d";
    hash = "sha256-pGL8vaE63ss2ZT2FoNDfDkeuCxjcbl02RmwwfHC/Vxg=";
  };
  nativeBuildInputs = [ gtk3 sassc ];

  patches = [
    ./colloid-src-git-reset.patch

    # Can be removed next release
    # Adds compatibility with the 2.x.x versions of the catppuccin python package
    # (fetchpatch {
    #   name = "catppuccin-python-compatibility.patch";
    #   url =
    #     "https://github.com/catppuccin/gtk/commit/355e12387f73b27cf4734a6a3eb431554fabb74f.patch";
    #   hash = "sha256-4vgZbNeGMtsQEitIWDCVb5o4fAjhVu3iIUttUYqtHPc=";
    # })
  ];

  buildInputs = [ gnome-themes-extra pythcat ];

  propagatedUserEnvPkgs = [ gtk-engine-murrine ];

  postUnpack = ''
    rm -rf source/colloid
    cp -r ${colloid-gtk-theme.src} source/colloid
    chmod -R +w source/colloid
  '';

  postPatch = ''
    patchShebangs --build colloid/install.sh colloid/build.sh
  '';

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    cp -r colloid colloid-base
    mkdir -p $out/share/themes
    export HOME=$(mktemp -d)

    python3 install.py ${variant} \
      ${
        lib.optionalString (accents != [ ]) "--accent "
        + builtins.toString accents
      } \
      ${lib.optionalString (size != [ ]) "--size " + size} \
      ${
        lib.optionalString (tweaks != [ ]) "--tweaks "
        + builtins.toString tweaks
      } \
      --dest $out/share/themes

    runHook postInstall
  '';

  passthru.updateScript = nix-update-script { };

  meta = with lib; {
    description = "Soothing pastel theme for GTK";
    homepage = "https://github.com/catppuccin/gtk";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = with maintainers; [ fufexan dixslyf ];
  };
}
