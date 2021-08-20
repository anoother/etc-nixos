{ config, pkgs, ... }:

{
  imports = map (x: ../modules + x) [
    /efi.nix
    /zigbee.nix
  ] ++ 
  [ ../notsecret/wysebee.nix ];

  powerManagement.cpuFreqGovernor = "conservative";

  networking.interfaces.enp1s0.useDHCP = true;

  #time.timeZone = "Europe/London";

  services.wakeonlan.interfaces = [ { interface = "enp1s0"; method = "magicpacket"; } ];

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change machine only after NixOS release notes say you
  # should.
  system.stateVersion = "20.03"; # Did you read the comment?

}
