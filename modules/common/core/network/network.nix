{ inputs, outputs, lib, config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [ wireguard-tools ];
  networking = {
    # dns
    networkmanager = { enable = true; };
    nameservers = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
    # search = [ "127.0.0.1" ];
    wg-quick.interfaces = {
      wg0 = {
        address = [ "10.177.100.76" "fd7d:76ee:e68f:a993:c1c9:1e68:ee1e:d818" ];
        privateKey = "CJr3ey5JUfB05C85BLHLHlyli/2IhfgVyIC8ds4n2kQ=";
        dns = [ "10.128.0.1" "fd7d:76ee:e68f:a993::1" ];
        listenPort = 1637;
        autostart = false;
        # fwMark = "0xca6c";
        mtu = 1320;
        peers = [
          # For a client configuration, one peer entry for the server will suffice.

          {
            # Public key of the server (not a file path).
            publicKey = "PyLCXAQT8KkM4T+dUsOQfn+Ub3pGxfGlxkIApuig+hk=";
            presharedKey = "1iOFgP0cHX9aK0rMKA7hntI0kY7O88qs/79G0blXyHI=";
            # Forward all the traffic via VPN.
            allowedIPs = [ "0.0.0.0/0" "::/0" ];
            # Or forward only particular subnets
            #allowedIPs = [ "10.100.0.1" "91.108.12.0/22" ];

            # Set this to the server IP and port.
            endpoint =
              "us3.vpn.airdns.org:1637"; # ToDo: route to endpoint not automatically configured https://wiki.archlinux.org/index.php/WireGuard#Loop_routing https://discourse.nixos.org/t/solved-minimal-firewall-setup-for-wireguard-client/7577
            # Send keepalives every 25 seconds. Important to keep NAT tables alive.
            persistentKeepalive = 20;
          }
        ];
      };
    };
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
  services.resolved = {
    enable = true;
    dnssec = "true";
    domains = [ "~." ];
    fallbackDns = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
    dnsovertls = "true";
  };
  # slows down boot time
  systemd.services.NetworkManager-wait-online.enable = false;
  programs = {
    ssh = {
      startAgent = true;
      askPassword =
        lib.mkForce "${pkgs.gnome.seahorse}/libexec/seahorse/ssh-askpass";
    };
    wireshark.enable = true;
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
