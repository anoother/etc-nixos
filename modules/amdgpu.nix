{ config, lib, pkgs, ... }:

{

  boot.initrd.kernelModules = [ "amdgpu" ];

  services.xserver.videoDrivers = [ "amdgpu" ];
  services.xserver.useGlamor = true;
  services.xserver.deviceSection = ''
    Option "TearFree" "true"
  '';

  # Vulkan:
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;

}
