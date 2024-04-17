{ ... }: {
  programs.cava = {
    enable = true;
    settings = {
      general.framerate = 120;
      smoothing.noise_reduction = 88;
      color = {
        gradient = 1;
        gradient_count = 4;
        gradient_color_1 = "'#8aadf4'";
        gradient_color_2 = "'#7dc4e4'";
        gradient_color_3 = "'#91d7e3'";
        gradient_color_4 = "'#cad3f5'";
        gradient_color_5 = "'#c6a0f6'";
        gradient_color_6 = "'#f5bde6'";
        gradient_color_7 = "'#ee99a0'";
        gradient_color_8 = "'#ed8796'";
      };
    };
  };
}
