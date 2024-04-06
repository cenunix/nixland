{ pkgs, ... }@args:
pkgs.pinned.buildLinux (args // rec {
  version = "6.6.0";
  modDirVersion = "6.6.0-rc5";

  kernelPatches = [ ];
  src = pkgs.pinned.fetchFromGitHub {
    owner = "steev";
    repo = "linux";
    rev = "f407eddf8f89860256c17f85550631263581079b";
    sha256 = "sha256-B9WtrWg7F6Rm72rgA36W6OWKLGo4cug7Sy3WOvols2Q=";
  };
  defconfig = "laptop_defconfig";
} // (args.argsOverride or { }))
