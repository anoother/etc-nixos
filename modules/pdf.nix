{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    img2pdf
    #xpaint # NO PACKAGE!
  ];
}

