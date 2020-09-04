{ config, pkgs, ... }:

{

  time.timeZone = "Europe/London";

  environment.systemPackages = with pkgs; [
    picom
    pnmixer
    numlockx
    feh
    scrot
    steam
    polybar
    dmenu
    google-drive-ocamlfuse
    konsole
    firefox
    hicolor-icon-theme
    lxappearance
    numix-gtk-theme
    numix-icon-theme
    numix-icon-theme-circle
    numix-icon-theme-square
    numix-cursor-theme
    numix-solarized-gtk-theme
    numix-sx-gtk-theme
    pa_applet
    libreoffice
    gimp
    inkscape
    blender
    dolphin
    powertop
    ghostwriter
    marktext
    notes-up
    notable
    typora
  ];

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

  hardware.bluetooth.enable = true;
  hardware.bluetooth.package = pkgs.bluezFull;
  services.blueman.enable = true;

  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
    #configFile = ''/etc/pulse/glitchfree-free.pa'';
    extraConfig = ''load-module module-udev-detect tsched=0'';
  };
  environment.etc."pulse/gsx1000.conf".source = ''/etc/nixos/files/gsx1000.conf'';

  services.udev.extraRules = ''
    ATTRS{manufacturer}=="Sennheiser", ATTRS{product}=="GSX 1000 Main Audio", ENV{PULSE_PROFILE_SET}="/etc/pulse/gsx1000.conf"
  '';

  # For Steam:
  hardware.pulseaudio.support32Bit = true;
  hardware.opengl.driSupport32Bit = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [ 
    pkgs.gutenprint
    pkgs.gutenprintBin
    pkgs.brlaser
    pkgs.brgenml1lpr
    pkgs.brgenml1cupswrapper
  ];

  fonts.fonts = with pkgs; [ 
    b612
    font-awesome
    font-awesome-ttf
    open-sans 
    unifont
    unifont_upper
  ];

  # Screen locking on sleep etc. (uses i3lock by default)
  programs.xss-lock.enable = false;

  systemd.user.services = {
    sxhkd = {
      description = "Simple X Hotkey Daemon";
      documentation = [ "man:sxhkd(1)" ];
      wantedBy = [ "graphical.target" ];
      path = [
        pkgs.utillinux
        pkgs.dmenu
        pkgs.konsole
      ];
      serviceConfig = {
        ExecStart = "${pkgs.sxhkd}/bin/sxhkd";
        ExecReload = "${pkgs.utillinux}/bin/kill -SIGUSR1 $MAINPID";
      };
    };
  };

}
