# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
  imports = map (x: ../modules + x) [
    /efi.nix
    /desktop.nix
    /amdgpu.nix
    /rocm.nix
    /3dprinting.nix
    /igvt-g.nix
    /development.nix
  ];

  #boot.kernelPackages = pkgs.linuxPackages_5_11;

  boot.tmpOnTmpfs = true;

  console.font = lib.mkDefault "${pkgs.terminus_font}/share/consolefonts/ter-u12n.psf.gz";
  console.useXkbConfig = true;

  #services.xserver = {
  #  xkbModel = "pc105";
  #  xkbVariant = "mac";
  #  #xkbOptions = "altwin:swap_lalt_lwin";
  #};

  networking.bonds.bond0 = {
    interfaces = [ "eno1" "eno2" "eno3" "eno4" ];
    driverOptions = {
      mode = "balance-rr";
      ad_select = "bandwidth";
    };
  };

  networking.interfaces.bond0 = {
    useDHCP = true;
    macAddress = "0c:c4:7a:88:4c:98"; # Because something (networkd?) is making up a MAC and this breaks DHCP
  };

  networking.dhcpcd.extraConfig = "noipv4ll";

  networking.networkmanager = {
    enable = true;
    unmanaged = [ "eno1" "eno2" "eno3" "eno4" ];
  };

  environment.systemPackages = with pkgs; [
    ipmitool
  ];

  virtualisation.kvmgt.vgpus = {
    "i915-GVTg_V5_1" = {
      uuid = [ "2a692636-05cc-11ec-8405-7fb5d764f760" ];
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "20.09"; # Did you read the comment?

}
