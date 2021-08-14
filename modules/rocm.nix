{ config, pkgs, ... }:

{
  #nixpkgs.overlays = [
  #  (import ./nixos-rocm)
  #];

  hardware.opengl.enable = true;
  hardware.opengl.extraPackages = with pkgs; [
    rocm-opencl-icd
    rocm-opencl-runtime
    rocm-smi
  ];

  environment.systemPackages = with pkgs; [
    libva-utils
  ];

}

