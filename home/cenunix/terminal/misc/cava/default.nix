{ ... }: {
  programs.cava = {
    enable = true;
    settings = {
      general.framerate = 120;
      smoothing.noise_reduction = 88;
    };
  };
}
