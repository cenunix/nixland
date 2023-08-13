{ inputs
, outputs
, lib
, config
, pkgs
, ...
}:
let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  # TODO: Configure your system-wide user settings (groups, etc), add more users as needed.
  users.users = {
    # FIXME: Replace with your username
    cenunix = {
      # TODO: You can set an initial password for your user.
      # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
      # Be sure to change it (using passwd) after rebooting!
      initialPassword = "changeme";
      isNormalUser = true;
      shell = pkgs.zsh;

      # openssh.authorizedKeys.keys = [
      #   # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      # ];
      # TODO: Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
      extraGroups =
        [
          "wheel"
          "networkManager"
        ]
        ++ ifTheyExist [
          "docker"
          "libvirtd"
          "kvm"
          "qemu-libvirtd"
        ];
      openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINhMaC2Hg0H3VjCiFyOlQmn8OWRuKSR05LIP1jdp5zpu cenunix@europa" ];
    };
  };
}
