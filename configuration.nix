# Edit machine configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, options, ... }:

let
  machine = builtins.readFile( ./hostname );
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./notsecret/users.nix
      ( /etc/nixos/machines + "/${machine}.nix" )
    ];

  networking.hostName = machine;

  nixpkgs.config = {
    allowUnfree = true;
  };

  nix.nixPath =
    options.nix.nixPath.default ++
    [ "nixpkgs-overlays=/etc/nixos/overlays-compat/" ]
  ;

  nixpkgs.overlays = let
    unstableTarball = fetchTarball "channel:nixos-unstable";
    localFork = /home/ahmad/projects/nixpkgs;
    localGit = fetchGit { url = localFork; rev = "master"; };
  in [
    (self: super: {
      unstable = import unstableTarball {
        config = config.nixpkgs.config;
        overlays = [];
      };
    })
    (self: super: {
      local = import localGit {
        config = config.nixpkgs.config;
        overlays = [];
      };
    })
    (self: super: {
      hack = import localFork {
        config = config.nixpkgs.config;
        overlays = [];
      };
    })
  ];

  environment.systemPackages = with pkgs; [
    #unstable.home-assistant
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

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  networking.firewall.enable = false;

  services.openssh.enable = true;
  services.openssh.permitRootLogin = "no";
  programs.ssh.startAgent = true;
  programs.mosh.enable = true;

  i18n.defaultLocale = "en_GB.UTF-8";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

}

