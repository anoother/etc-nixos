{ config, pkgs, ... }:

{

  imports = [
    ../notsecret/zigbee.nix
  ];

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
