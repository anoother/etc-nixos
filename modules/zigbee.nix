{ config, pkgs, ... }:

{

  services.home-assistant = {
    enable = true;
    package = pkgs.unstable.home-assistant;
    configWritable = true;
  };

  services.prometheus = {
    enable = true;
  };
}

