{ config, pkgs, lib, ... }:
with lib;
let
  # use the latest possible nvidia package
  nvStable = config.boot.kernelPackages.nvidiaPackages.stable.version;
  nvBeta = config.boot.kernelPackages.nvidiaPackages.beta.version;

  nvidiaPackage = if (versionOlder nvBeta nvStable) then
    config.boot.kernelPackages.nvidiaPackages.stable
  else
    config.boot.kernelPackages.nvidiaPackages.beta;

  device = config.modules.device;
  env = config.modules.usrEnv;
in {
  config = mkIf (device.gpu == "nvidia" || device.gpu == "hybrid-nv") {
    # nvidia drivers are unfree software
    nixpkgs.config.allowUnfree = true;

    services.xserver = mkMerge [
      {
        videoDrivers = [ "nvidia" ];
      }

      # xorg settings
      (mkIf (!env.isWayland) {
        # disable DPMS
        monitorSection = ''
          Option "DPMS" "false"
        '';

        # disable screen blanking in general
        serverFlagsSection = ''
          Option "StandbyTime" "0"
          Option "SuspendTime" "0"
          Option "OffTime" "0"
          Option "BlankTime" "0"
        '';
      })
    ];

    boot = {
      # blacklist nouveau module so that it does not conflict with nvidia drm stuff
      # also the nouveau performance is godawful, I'd rather run linux on a piece of paper than use nouveau
      blacklistedKernelModules = [ "nouveau" ];
    };

    environment = {
      sessionVariables = mkMerge [
        { LIBVA_DRIVER_NAME = "nvidia"; }

        (mkIf (env.isWayland) {
          WLR_NO_HARDWARE_CURSORS = "1";
          __GLX_VENDOR_LIBRARY_NAME = "nvidia";
          MESA_DISK_CACHE_SINGLE_FILE = "1";
          __GL_SHADER_DISK_CACHE_SKIP_CLEANUP = "1";
          DXVK_STATE_CACHE = "1";
          MOZ_DISABLE_RDD_SANDBOX = "1";
          NVD_BACKEND = "direct";
          # GBM_BACKEND = "nvidia-drm"; # breaks firefox apparently
          VDPAU_DRIVER = "va_gl";
        })

        (mkIf ((env.isWayland) && (device.gpu == "hybrid-nv")) {
          #__NV_PRIME_RENDER_OFFLOAD = "1";
          # WLR_DRM_DEVICES = mkDefault "/dev/dri/card1:/dev/dri/card0";
        })
      ];
      systemPackages = with pkgs; [
        glxinfo
        vulkan-tools
        vulkan-loader
        vulkan-validation-layers
        glmark2
        libva
        libva-utils
        xorg.libxcb
      ];
    };

    hardware = {
      nvidia = {
        # package = mkDefault config.boot.kernelPackages.nvidiaPackages.beta;
        package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
          version = "535.171.04";
          sha256_64bit = "sha256-6PFkO0vJXYrNZaRHB4SpfazkZC8UkjZGYSDbKqlCQ3o=";
          sha256_aarch64 =
            "sha256-G0/GiObf/BZMkzzET8HQjdIcvCSqB1uhsinro2HLK9k=";
          openSha256 = "sha256-wvRdHguGLxS0mR06P5Qi++pDJBCF8pJ8hr4T8O6TJIo=";
          settingsSha256 =
            "sha256-9wqoDEWY4I7weWW05F4igj1Gj9wjHsREFMztfEmqm10=";
          persistencedSha256 =
            "sha256-d0Q3Lk80JqkS1B54Mahu2yY/WocOqFFbZVBh+ToGhaE=";

          # patches = [ rcu_patch ];
        };
        modesetting.enable = mkDefault true;
        prime.offload.enableOffloadCmd = device.gpu == "hybrid-nv";
        # powerManagement = {
        #   enable = mkDefault true;
        #   finegrained = mkDefault true;
        # };

        # use open source drivers by default, hosts may override this option if their gpu is
        # not supported by the open source dexplicit sync.rivers
        open = false;
        nvidiaSettings = false; # add nvidia-settings to pkgs, useless on nixos
        # nvidiaPersistenced = true;
        # forceFullCompositionPipeline = true;
      };

      opengl = {
        enable = true;
        extraPackages = with pkgs; [ nvidia-vaapi-driver libvdpau-va-gl ];
        extraPackages32 = with pkgs.pkgsi686Linux; [ nvidia-vaapi-driver ];
      };
    };
  };
}
