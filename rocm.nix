{ config, pkgs, ... }:

{
  nixpkgs.overlays = [
    (import ./nixos-rocm)
  ];

  hardware.opengl.enable = true;
  hardware.opengl.extraPackages = [ pkgs.rocm-opencl-icd ];

  services.xserver.useGlamor = true;
}

