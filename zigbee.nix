{ config, pkgs, ... }:

{
  services.home-assistant = {
    enable = true;
    configWritable = true;
  };
  services.prometheus = {
    enable = true;
  };
}

