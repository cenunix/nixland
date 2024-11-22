{ lib, pkgs, inputs, ... }:
let
  inherit (lib)
    concatMapStrings optionalString splitString elemAt length map toLower;
  inherit (lib) capitalise;
  inherit (builtins) readFile fromJSON;
in {

  buildNodeModules = dir: npmDepsHash:
    let
      packageJSON = fromJSON (readFile (dir + /package.json));

      pkg = pkgs.callPackage ({ buildNpmPackage, ... }:
        buildNpmPackage {
          pname = packageJSON.name;
          inherit (packageJSON) version;

          src = dir;

          inherit npmDepsHash;
          dontNpmBuild = true;
        }) { };
    in "${pkg}/lib/node_modules/${pkg.pname}/node_modules";

  buildGirTypes = { configPath, packages, pname, }:
    let
      withGirNames = map (package: {
        inherit package;
        girName = if package.pname == "astal-wireplumber" then
          "AstalWp-0.1"
        else if package.name == "astal-0.1.0" then
          "AstalIO-0.1"
        else if package.name == "astal-3.0.0" then
          "Astal-3.0"
        else
          (concatMapStrings capitalise (splitString "-" package.pname))
          + "-0.1";
      }) packages;
    in {
      "${configPath}${
        optionalString (length packages == 1)
        "/${toLower (elemAt withGirNames 0).girName}"
      }".source = pkgs.callPackage ./mk-types {
        inherit (inputs) ts-for-gir-src;
        inherit pname withGirNames;
      };
    };
}
