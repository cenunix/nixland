{ config, pkgs, lib, ... }: {
  services.ollama.enable = true;
  services.ollama.acceleration = "rocm";
  environment.systemPackages = with pkgs; [
    ollama

    amdvlk

    rocm-opencl-icd # gaming?

    rocmPackages.clr.icd # following for GPU AI acceleration
    rocmPackages.rocm-smi
    rocmPackages.clr
    rocmPackages.hipblas
    rocmPackages.rocblas
    rocmPackages.rocsolver
    rocmPackages.rocm-comgr
    rocmPackages.rocm-runtime
    rocmPackages.rocsparse
    rocm-opencl-runtime # gaming?
  ];
}
