{ pkgs
, inputs
, ...
}: {
  environment = {
    systemPackages = with pkgs; [
      # packages necessery for thunar thumbnails
      xfce.tumbler
      libgsf # odf files
      ffmpegthumbnailer
      ark # GUI archiver for thunar archive plugin
      sshfs # FUSE-based filesystem that allows remote filesystems to be mounted over SSH
      samba
      fuse
      gnome.nautilus
    ];
  };
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.samba.enable = true;
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
