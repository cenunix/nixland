let
  # users
  cenunix = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMnF0E4TddhnSUdsHWaTwTv2x7onGOkWhL7BtcKGQgx4 cenunix@europa";

  # hosts
  callisto = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMOwh+M09iLFaFAP92YMs2Bl2jg6hPnb3GGo925cTW9q";
  europa = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKr/JFI1vb+xZ7yMVKu3NxxhmylZrv76nLE36S2tEvli";
  io = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGqd9WnhRn/pi5eyCxXdxFE+nPw1Amf58QV9zgCazEWX";
in
{
  # core system secrets
  "mediaserver.age".publicKeys = [ europa io callisto cenunix ];
  "spotify-player.age".publicKeys = [ europa io callisto cenunix ];
}
