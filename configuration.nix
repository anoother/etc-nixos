# Edit machine configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, options, lib, ... }:

let nixos_hostname = builtins.getEnv "NIXOS_HOSTNAME"; in
let 
  hostname = if (nixos_hostname == "") then builtins.readFile( ./hostname ) else nixos_hostname;
  inherit nixos_hostname;
in
{
  imports =
    [
      ./hardware-configuration.nix
      ./notsecret/users.nix
      ( ./machines + "/${hostname}.nix" )
    ];

  networking.hostName = hostname;
  networking.useDHCP = lib.mkOverride 2000 false; # Default priority is 1000, lowest takes precedence

  nixpkgs.config = {
    allowUnfree = true;
  };

  nixpkgs.overlays = let
    unstableTarball = fetchTarball "channel:nixos-unstable";
  in [
    (self: super: {
      unstable = import unstableTarball {
        config = config.nixpkgs.config;
        overlays = [];
      };
    })
  ];

  environment.systemPackages = with pkgs; [
    file
    git
    gitAndTools.tig
    wget
    vim
    lm_sensors
    screen
    mprime
    htop
    iperf3
    hddtemp
    smartmontools
    hdparm
    sysstat
    usbutils
    parted
    psmisc
    stow
    ncdu
    tree
    unzip
    pciutils
    lsof
    jq
  ];

  networking.firewall.enable = false;

  services.openssh.enable = true;
  services.openssh.permitRootLogin = "no";
  programs.ssh.startAgent = true;
  programs.mosh.enable = true;

  i18n.defaultLocale = "en_GB.UTF-8";

}

