{ config, pkgs, ... }:

{

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = false;
      dockerSocket.enable = false;
    };
    docker = {
      enable = true;
    };
  };

  environment.systemPackages = [
    pkgs.gnumake
    pkgs.python38Packages.virtualenvwrapper
  ];

}

