{ inputs, outputs, lib, config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [ wireguard-tools ];
  networking = {
    # dns
    networkmanager = { enable = true; };
    nameservers = [ "1.1.1.1" "1.0.0.1" ];
    firewall = {
      enable = true;
      checkReversePath = false;
      # if your minecraft server is not worky
      # this is probably why
      trustedInterfaces = [ "virbr0" ];
      allowedTCPPorts = [
        137
        138
        139
        389
        445
        443
        80
        22
        1080
        7000
        8080
        8096
        8097
        8112
        8920
        5452
        5432
        5433
        5454
        23313
        25565
        49160
        32400
        9117
        50112
      ];
      allowedUDPPorts = [
        137
        138
        139
        389
        445
        443
        80
        1637
        19132
        23313
        49160
        44857
        8080
        50112
        51820
      ];
      allowPing = false;
      logReversePathDrops = true;
    };
  };
  # services.resolved = {
  #   enable = true;
  #   dnssec = "true";
  #   domains = [ "~." ];
  #   fallbackDns = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
  #   dnsovertls = "true";
  # };
  # slows down boot time
  systemd.services.NetworkManager-wait-online.enable = false;
  programs = {
    ssh = {
      startAgent = true;
      askPassword =
        lib.mkForce "${pkgs.gnome.seahorse}/libexec/seahorse/ssh-askpass";
    };
  };
  services.openssh = {
    enable = true;
    startWhenNeeded = false;
    settings = {
      PermitRootLogin = lib.mkForce "yes";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = lib.mkDefault false;
      UseDns = false;
      X11Forwarding = false;
    };

    # the ssh port(s) should be automatically passed to the firewall's allowedTCPports
    openFirewall = true;
    ports = [ 2317 ];

    hostKeys = [
      {
        bits = 4096;
        path = "/etc/ssh/ssh_host_rsa_key";
        type = "rsa";
      }
      {
        bits = 4096;
        path = "/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
  };
}
