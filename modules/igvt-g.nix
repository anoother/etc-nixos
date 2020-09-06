{ config, pkgs, ... }:

{
  virtualisation.kvmgt.enable = true;
  virtualisation.libvirtd.enable = true;

  environment.systemPackages = with pkgs; [
    barrier
    looking-glass-client
    spice-gtk
    virtmanager
    virt-viewer
  ];

  users.extraUsers.ahmad.extraGroups = [ "libvirtd" ];

  systemd.tmpfiles.rules = [
    "f /dev/shm/looking-glass 0660 ahmad kvm"
  ];

  security.wrappers.spice-client-glib-usb-acl-helper.source = "${pkgs.spice-gtk}/bin/spice-client-glib-usb-acl-helper";

}
