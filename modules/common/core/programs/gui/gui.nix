{ pkgs, inputs, lib, config, ... }:
with lib;
let env = config.modules.usrEnv;
in {
  services.flatpak.enable = true;
  hardware = mkIf (env.desktop == "Gnome") { pulseaudio.enable = false; };
  programs.hyprland = mkIf (env.desktop == "Hyprland") { enable = true; };
  environment = {
    systemPackages = with pkgs; [
      # packages necessary for thunar thumbnails
      xfce.tumbler
      libgsf # odf files
      ffmpegthumbnailer
      ark # GUI archiver for thunar archive plugin
      sshfs # FUSE-based filesystem that allows remote filesystems to be mounted over SSH
      fuse
      cifs-utils
      keyutils
    ];
  };
  services.avahi.enable = true;
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  # For mount.cifs, required unless domain name resolution is not needed.
  # fileSystems."/mnt/share" = {
  #   device = "//<IP_OR_HOST>/path/to/share";
  #   fsType = "cifs";
  #   options = let
  #     # this line prevents hanging on network split
  #     automount_opts =
  #       "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
  #
  #   in [ "${automount_opts},credentials=/etc/nixos/smb-secrets" ];
  # };
  # services.samba = {
  #   enable = true;
  #   securityType = "user";
  #   openFirewall = true;
  #   extraConfig = ''
  #     workgroup = WORKGROUP
  #     server string = smbnix
  #     netbios name = smbnix
  #     security = user
  #     allow insecure wide links = yes
  #     #use sendfile = yes
  #     #max protocol = smb2
  #     # note: localhost is the ipv6 localhost ::1
  #     #hosts allow = 192.168.0. 127.0.0.1 localhost
  #     #hosts deny = 0.0.0.0/0
  #     #guest account = nobody
  #     #map to guest = bad user
  #   '';
  #   shares = {
  #     public = {
  #       path = "/home/cenunix/Games";
  #       browseable = "yes";
  #       public = "no";
  #       writable = "yes";
  #       "read only" = "no";
  #       "guest ok" = "no";
  #       printable = "no";
  #       "force user" = "cenunix";
  #       "follow symlinks" = "yes";
  #       "wide links" = "yes";
  #       # "force group" = "wheel";
  #     };
  #   };
  # };
  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
    discovery = true;
    hostname = "SMBNIX";
  };
  programs = {
    # the thunar file manager
    # we enable thunar here and add plugins instead of in systemPackages
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-media-tags-plugin
      ];
    };
    # registry for linux, thanks to gnome
    dconf.enable = true;
    # network inspection utility
    wireshark.enable = true;
    # gnome's keyring manager
    seahorse.enable = true;
    # networkmanager tray uility
    nm-applet.enable = true;
  };
}
