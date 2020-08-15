{ config, pkgs, ... }:

{
  virtualisation.kvmgt.enable = true;
  environment.systemPackages = with pkgs; [
    looking-glass-client
    virtmanager
  ];
  virtualisation.libvirtd.enable = true;
  users.extraUsers.ahmad.extraGroups = [ "libvirtd" ];
}

