{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  osConfig,
  ...
}:
with lib; let
  device = osConfig.modules.device;
  acceptedTypes = ["desktop" "laptop" "armlaptop"];
in {
  config = mkIf (builtins.elem device.type acceptedTypes) {
    home.packages = with pkgs; [
      # spotify command line interface
      (spotify-player.overrideAttrs (o: rec {
        pname = "spotify-player";
        version = "0.17.0";
        src = pkgs.fetchFromGitHub {
          owner = "aome510";
          repo = pname;
          rev = "refs/tags/v${version}";
          hash = "sha256-fGDIlkTaRg+J6YcP9iBcJFuYm9F0UOA+v/26hhdg9/o=";
        };
        cargoDeps = pkgs.rustPlatform.importCargoLock {
          lockFile = src + "/Cargo.lock";
          allowBuiltinFetchGit = true;
        };
      }))
    ];
    xdg.configFile."spotify-player/theme.toml".source = ./theme.toml;
    xdg.configFile."spotify-player/app.toml".text = ''
      client_id = "545909c803cb4b1ba7e439a768cd636f"
      theme = "Catppuccin-mocha"
      app_refresh_duration_in_ms = 32
      playback_refresh_duration_in_ms = 0
      cover_image_refresh_duration_in_ms = 2000
      track_table_item_max_len = 32
      enable_media_control = true
      default_device = "spotify-player"
      play_icon = "\u23f8"
      pause_icon = "\u25b6"
      cover_img_length = 9
      cover_img_width = 5
      playback_window_width = 6
      [device]
      name = "spotify-player"
      device_type = "speaker"
      volume = 100
      bitrate = 320
      audio_cache = false
    '';
  };
}
