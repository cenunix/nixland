let
  # users
  cenunix = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMnF0E4TddhnSUdsHWaTwTv2x7onGOkWhL7BtcKGQgx4 cenunix@europa";

  # hosts
  europa = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIobUFvsg1s7rlVXiP1PgQPNVgsaiENqQzlULdwPMJTH";
in {
  # core system secrets
  "mediaserver.age".publicKeys = [europa cenunix];
}
