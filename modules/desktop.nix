{ config, pkgs, ... }:

{

  imports = [
    ./pdf.nix
    ./x.nix
    ./printing.nix
  ];

  time.timeZone = "Europe/London";

  environment.systemPackages = with pkgs; [
    _1password
    picom
    pnmixer
    numlockx
    feh
    scrot
    polybar
    dmenu
    xdo
    xdotool
    xtitle
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
    gimp-with-plugins
    inkscape
    blender
    dolphin
    powertop
    ghostwriter
    marktext
    notes-up
    notable
    typora
    kate
    kitty
    google-chrome
    obs-studio
    zoom-us
    solaar
    ripcord
    xscreensaver
    rss-glx
  ];

  services.xserver = {
    windowManager.bspwm.enable = true;
    displayManager.sddm.enable = false;
    desktopManager.gnome.enable = true;
    xkbOptions = "caps:ctrl_modifier,caps:escape";
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
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0664", TAG+="uaccess"
  '';

  # For Steam:
  #hardware.pulseaudio.support32Bit = true;
  #hardware.opengl.driSupport32Bit = true;
  programs.steam.enable = true;

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

    xscreensaver = {
      description = "Screensaver";
      documentation = [ "man:XSceenSaver(1)" ];
      wantedBy = [ "graphical.target" ];
      path = with pkgs; [
        xscreensaver
        rss-glx
      ];
      serviceConfig = {
        ExecStart = "${pkgs.xscreensaver}/bin/xscreensaver --no-splash";
      };
    };

    solaar = {
      description = "Logitech mouse controls";
      wantedBy = [ "graphical.target" ];
      path = [
        pkgs.solaar
      ];
      serviceConfig = {
        ExecStart = "${pkgs.solaar}/bin/solaar -w hide";
      };
    };

  };

}
