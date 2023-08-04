let
  # users
  cenunix = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMnF0E4TddhnSUdsHWaTwTv2x7onGOkWhL7BtcKGQgx4 cenunix@europa";

  # hosts
  callisto = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMOwh+M09iLFaFAP92YMs2Bl2jg6hPnb3GGo925cTW9q";
  europa = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKr/JFI1vb+xZ7yMVKu3NxxhmylZrv76nLE36S2tEvli";
in
{
  # core system secrets
  "mediaserver.age".publicKeys = [ europa cenunix ];
  "spotify-player.age".publicKeys = [ europa callisto cenunix ];
}
