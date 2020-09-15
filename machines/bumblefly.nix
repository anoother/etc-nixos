{ config, pkgs, ... }:

{
  imports = map (x: ../modules + x) [
    /x.nix
  ] ++
  [
    ../notsecret/wifi.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_5_7; # AT LEAST 5.6 required for root fs
  fileSystems."/".options = [ "compress_algorithm=lz4" ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/disk/by-id/usb-TS-RDF5A_Transcend_000000000004-0:0"; # or "nodev" for efi only

  #time.timeZone = "Europe/London";

  networking.useDHCP = true;

  #services.wakeonlan.interfaces = [ { interface = "eno1"; method = "magicpacket"; } ];

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change machine only after NixOS release notes say you
  # should.
  system.stateVersion = "20.03"; # Did you read the comment?

}
