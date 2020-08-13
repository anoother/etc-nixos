{ config, pkgs, ... }:

{
  imports = [
    ./desktop.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/London";

  services.xserver = {
    enable = true;
    enableCtrlAltBackspace = true;
    windowManager.bspwm.enable = true;
    displayManager.sddm.enable = false;
    #displayManager.defaultSession = "none+bspwm";
    desktopManager = {
      xfce = {
        enable = true;
        noDesktop = false;
        enableXfwm = true;
      };
      gnome3 = {
        enable = true;
      };
    };
    monitorSection = ''#Option "DPMS" "false"
      Modeline "2560x1440_75" 299.00  2560 2608 2640 2720  1440 1443 1448 1470 +hsync -vsync
      Option "PreferredMode" "2560x1440_75"
    '';
    libinput = {
        enable = true;
        accelProfile = "flat";
    };
    inputClassSections = [
      ''
	Identifier "Touchpad"
	MatchIsTouchpad "on"
	Option "AccelProfile" "adaptive"
	Option "ClickMethod" "clickfinger"
	Option "NaturalScrolling" "true"
      ''
      ''
	Identifier "Sennheiser GSX 1000 Hotkeys"
	MatchProduct "Sennheiser GSX 1000 Main Audio"
	Option "Ignore" "on"
      ''
    ];
  };
  #environment.etc."../var/lib/lightdm/.config/monitors.xml".source = ''/home/ahmad/.config/monitors.xml'';

  # Intel graphics stuff
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
      intel-media-driver # only available starting nixos-19.03 or the current nixos-unstable
    ];
  };

  services.autorandr.enable = false;

  powerManagement = {
    enable = true;
    # if BT is enabled on sleep/hibernate etc., the system wakes immediately:
    powerDownCommands = "echo 'power off' | bluetoothctl";
    resumeCommands = "echo 'power on' | bluetoothctl";
  };

  environment.systemPackages = with pkgs; [
    thunderbolt
  ];

  networking.networkmanager.insertNameservers = [ "8.8.8.8" "8.8.4.4" ];

  services.wakeonlan.interfaces = [ { interface = "eno1"; method = "magicpacket"; } ];

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change machine only after NixOS release notes say you
  # should.
  system.stateVersion = "20.03"; # Did you read the comment?

}
