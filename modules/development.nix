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

  environment.systemPackages = with pkgs; [
    gnumake
  ];

}

