{ config, pkgs, ... }:

{
  imports = map (x: ../modules + x) [
    /x.nix
  ] ++
  [
    ../notsecret/wifi.nix
  ];

  boot.kernelPackages = pkgs.unstable.linuxPackages_zen; # AT LEAST .6 required for root fs
  fileSystems."/".options = [ "compress_algorithm=lz4" ];
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/disk/by-id/usb-TS-RDF5A_Transcend_000000000004-0:0"; # or "nodev" for efi only

  boot.kernelParams = [ "nvidia-drm.modeset=1" ];
  boot.loader.grub.gfxmodeBios = "1280x1024x24";
  boot.loader.grub.gfxpayloadBios = "keep";
  services.xserver.videoDrivers = [ "nvidia" ];
  environment.variables = {
    "__GL_YIELD" = "USLEEP";
    "__GL_SYNC_TO_VBLANK" = "0";
  };

  #time.timeZone = "Europe/London";

  networking.useDHCP = true;

  environment.systemPackages = with pkgs; [
    midori
    unstable.blender
    glxinfo
    glmark2
    firefox-bin
    hwinfo
    sg3_utils
    lsscsi
  ];

  #services.wakeonlan.interfaces = [ { interface = "eno1"; method = "magicpacket"; } ];

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change machine only after NixOS release notes say you
  # should.
  system.stateVersion = "20.03"; # Did you read the comment?

}
