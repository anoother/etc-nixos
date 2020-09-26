{ config, pkgs, ... }:

{

  imports = [
    ../notsecret/zigbee.nix
  ];

  networking.wireless.extraConfig = ''
    freq_list=5160 5170 5180 5190 5200 5210 5220 5230 5240 5250 5260 5270 5280 5290 5300 5310 5320 5340 5480 5500 5510 5520 5530 5540 5550 5560 5570 5580 5590 5600 5610 5620 5630 5640 5660 5670 5680 5690 5700 5710 5720 5745 5755 5765 5775 5785 5795 5805 5825 5845 5865
  '';

  services.zigbee2mqtt = {
    enable = true;
    config = {
      #homeassistant = config.services.home-assistant.enable;
      homeassistant = false;
      permit_join = true;
      serial = {
        adapter = "deconz";
        port = "/dev/serial/by-id/usb-dresden_elektronik_ingenieurtechnik_GmbH_ConBee_II_DE2217766-if00";
      };
    };
  };

  services.mosquitto = {
    enable = true;
    allowAnonymous = true;
    users = {};
  };

}
