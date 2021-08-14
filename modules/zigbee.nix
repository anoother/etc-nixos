{ config, pkgs, ... }:

{

  imports = [
    ../notsecret/zigbee.nix
  ];

  networking.wireless.extraConfig = ''
    freq_list=5180 5200 5220 5240 5260 5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700
  '';

  services.zigbee2mqtt = {
    enable = true;
    settings = {
      #homeassistant = config.services.home-assistant.enable;
      homeassistant = false;
      permit_join = true;
      serial = {
        adapter = "deconz";
        port = "/dev/serial/by-id/usb-dresden_elektronik_ingenieurtechnik_GmbH_ConBee_II_DE2217766-if00";
      };
      advanced = {
        log_level = "debug";
      };
    };
  };

  services.mosquitto = {
    enable = true;
    allowAnonymous = true;
    users = {};
  };

}
