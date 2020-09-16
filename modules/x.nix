{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    enableCtrlAltBackspace = true;
    desktopManager = {
      xfce = {
        enable = true;
        noDesktop = false;
        enableXfwm = true;
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
}
