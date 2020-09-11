{ config, pkgs, ... }:

{
  imports = map (x: ../modules + x) [
    /zigbee.nix
  ] ++
  [
    ../notsecret/wifi.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "nomodeset" ];
  boot.kernelModules = [ "dme1737" ];

  #time.timeZone = "Europe/London";

  networking.useDHCP = true;

  #services.xserver = {
  #  enable = true;
  #  enableCtrlAltBackspace = true;
  #  desktopManager = {
  #    xfce = {
  #      enable = true;
  #      noDesktop = false;
  #      enableXfwm = true;
  #    };
  #    gnome3 = {
  #      enable = false;
  #    };
  #  };
  #  libinput = {
  #      enable = true;
  #      accelProfile = "flat";
  #  };
  #  inputClassSections = [
  #    ''
  #      Identifier "Touchpad"
  #      MatchIsTouchpad "on"
  #      Option "AccelProfile" "adaptive"
  #      Option "ClickMethod" "clickfinger"
  #      Option "NaturalScrolling" "true"
  #    ''
  #    ''
  #      Identifier "Sennheiser GSX 1000 Hotkeys"
  #      MatchProduct "Sennheiser GSX 1000 Main Audio"
  #      Option "Ignore" "on"
  #    ''
  #  ];
  #};

  #services.wakeonlan.interfaces = [ { interface = "eno1"; method = "magicpacket"; } ];

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change machine only after NixOS release notes say you
  # should.
  system.stateVersion = "20.03"; # Did you read the comment?

}
