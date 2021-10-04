{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    enableCtrlAltBackspace = true;
    layout = "gb,us";
    desktopManager = {
      xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
      };
    };
    libinput = {
        enable = true;
        mouse = {
          accelProfile = "flat";
        };
        touchpad = {
          accelProfile = "adaptive";
          clickMethod = "clickfinger";
          naturalScrolling = true;
        };
    };
    inputClassSections = [
      ''
        Identifier "Sennheiser GSX 1000 Hotkeys"
        MatchProduct "Sennheiser GSX 1000 Main Audio"
        Option "Ignore" "on"
      ''
    ];
  };
}
