{
  buildLinux,
  fetchFromGitHub,
  lib,
  ...
} @ args:
with lib;
  buildLinux (args
    // rec {
      version = "6.3.5";
      modDirVersion = "6.3.8";

      kernelPatches = [];
      extraMeta.branch = "lenovo-x13s-linux-6.3.y";

      src = fetchFromGitHub {
        owner = "steev";
        repo = "linux";
        rev = "ab87d34f0b5ddd78093b8aa906939ae91984b2ab";
        sha256 = "sha256-aZMahaEi5wZr62sMlCF92pECXlQBZmurN1r8iouLMso=";
      };
      defconfig = "laptop_defconfig";
    }
    // (args.argsOverride or {}))
