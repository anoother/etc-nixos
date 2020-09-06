# Edit machine configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let machine = builtins.readFile( ./hostname ); in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./users.nix
      (builtins.toPath ''/etc/nixos/${machine}.nix'' )
    ];

  networking.hostName = machine;

  environment.systemPackages = with pkgs; [
    file
    git
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
  ];

  nixpkgs.config.allowUnfree = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  networking.firewall.enable = false;

  services.openssh.enable = true;
  services.openssh.permitRootLogin = "no";
  programs.mosh.enable = true;

  i18n.defaultLocale = "en_GB.UTF-8";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

}

