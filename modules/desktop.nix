{ config, pkgs, ... }:

{

  imports = [
    ./x.nix
  ];

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
    unstable.blender
    dolphin
    powertop
    ghostwriter
    marktext
    unstable.notes-up
    notable
    typora
  ];

  services.xserver = {
    windowManager.bspwm.enable = true;
    displayManager.sddm.enable = false;
    desktopManager.gnome3.enable = true;
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.package = pkgs.bluezFull;
  services.blueman.enable = true;

  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
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
        pkgs.bspwm
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
