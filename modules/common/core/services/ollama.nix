{ config, pkgs, lib, ... }: {
  # services.ollama.enable = true;
  # services.ollama.acceleration = "rocm";
  environment.systemPackages = with pkgs; [
    (ollama.override { acceleration = "cuda"; })
    lmstudio
  ];
}
