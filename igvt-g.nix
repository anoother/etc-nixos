{ config, pkgs, ... }:

{
  virtualisation.kvmgt.enable = true;
  virtualisation.libvirtd.enable = true;

  environment.systemPackages = with pkgs; [
    barrier
    looking-glass-client
    virtmanager
  ];

  users.extraUsers.ahmad.extraGroups = [ "libvirtd" ];

  systemd.tmpfiles.rules = [
    "f /dev/shm/looking-glass 0660 ahmad kvm"
  ];

}

