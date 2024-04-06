{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [ ./bootloaders ./media ./hardware ./network ./virtualization ];
}
