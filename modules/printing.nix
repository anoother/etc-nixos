{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    cups-filters # Needed for IPP Everywhere (driverless)
  ];

  services.printing.enable = true;
  services.printing.drivers = [ 
  ];  

  services.avahi.enable = true;
  services.avahi.nssmdns = true; # Needed for CUPS driverless printing

  hardware.sane.enable = true;
  hardware.sane.extraBackends = [ pkgs.sane-airscan ];

  nixpkgs.config.packageOverrides = pkgs: {
    xsaneGimp = pkgs.xsane.override { gimpSupport = true; };
  };

  services.saned.enable = true;

}
