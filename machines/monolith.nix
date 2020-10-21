# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
  imports = map (x: ../modules + x) [
    /efi.nix
    /3dprinting.nix
  ] ++
  [ ../notsecret/storage-server.nix ];

  boot.kernelPackages = pkgs.linuxPackages_5_4;

  console.font = lib.mkDefault "${pkgs.terminus_font}/share/consolefonts/ter-u12n.psf.gz";
  console.useXkbConfig = true;

  networking.useDHCP = false;
  networking.interfaces.eno0.useDHCP = true;
  networking.interfaces.eth2.useDHCP = true;
  networking.interfaces.enp6s0.useDHCP = true;
  networking.interfaces.enp6s0.mtu = 9000;
  networking.interfaces.enp7s0.useDHCP = true;
  networking.interfaces.enp7s0.mtu = 9000;

  environment.systemPackages = with pkgs; [
    ipmitool
  ];

  system.stateVersion = "20.03"; # Did you read the comment?

}

