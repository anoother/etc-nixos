{ config, pkgs, ... }:

{
  nixpkgs.overlays = [
    (import ./nixos-rocm)
  ];

  hardware.opengl.enable = true;
  hardware.opengl.extraPackages = [ pkgs.rocm-opencl-icd ];

  environment.systemPackages = with pkgs; [
    libva-utils
  ];

  services.xserver.useGlamor = true;
}

