{ pkgs
, ...
} @ args:
pkgs.pinned.buildLinux (args
  // rec {
  version = "6.5.5";
  modDirVersion = version;

  kernelPatches = [ ];
  extraMeta.branch = "lenovo-x13s-linux-6.3.y";

  src = pkgs.pinned.fetchFromGitHub {
    owner = "steev";
    repo = "linux";
    rev = "4f960402118224ab18a45f4a4e698f69b024b6af";
    sha256 = "wTLnqLbJ1tCzyyDq0peFCHolN5oj6aL0Wb2dEZY7zwQ=";
  };
  defconfig = "laptop_defconfig";
}
  // (args.argsOverride or { }))
