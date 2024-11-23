{ inputs, outputs, lib, config, pkgs, ... }: {
  nix = let flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    # Opinionated: make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    # Garbage collection, delete older than 7 days 
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };
    # channel.enable = false;
    settings = {
      # enable new nix command and flakes
      # and also "unintended" recursion as well as content addresssed
      extra-experimental-features = [
        "flakes" # flakes
        "nix-command" # experimental nix commands
        "ca-derivations" # content addressed nix
        # "repl-flake" # allow passing installables to nix repl # became non experimental as of 2.20 IIRC
      ];
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
      # use binary cache, its not gentoo
      # builders-use-substitutes = true;
      # allow sudo users to mark the following values as trusted
      allowed-users = [ "root" "@wheel" ];
      # only allow sudo users to manage the nix store
      trusted-users = [ "root" "@wheel" ];
      # let system decide max number of jobs
      # max-jobs = "auto";
      # don't warn me that my git tree is dirty, I know
      warn-dirty = false;
      # maximum number of parallel TCP connections used to fetch imports and binary caches, 0 means no limit
      # http-connections = 50;
      # whether to accept nix configuration from a flake without prompting
      # accept-flake-config = true;
      # execute builds inside cgroups
      # use-cgroups = true;
      # for direnv GC roots
      # keep-derivations = false;
      # keep-outputs = false;
      # use binary cache, its not gentoo
      # Opinionated: disable global registry
      flake-registry = "";
      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://hyprland.cachix.org"
        "https://nix-gaming.cachix.org" # nix-gaming
        "https://anyrun.cachix.org"
        "https://walker.cachix.org"
        "https://walker-git.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
        "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
        "walker.cachix.org-1:fG8q+uAaMqhsMxWjwvk0IMb4mFPFLqHjuvfwQxE4oJM="
        "walker-git.cachix.org-1:vmC0ocfPWh0S/vRAQGtChuiZBTAe4wiKDeyyXM0/7pM="
      ];
    };
  };
}
