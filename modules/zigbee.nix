{ config, pkgs, ... }:

{

  imports = [
    ../notsecret/zigbee.nix
  ];

  networking.wireless.extraConfig = ''
    freq_list=5180 5200 5220 5240 5260 5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700
  '';
 
  nixpkgs.overlays = [
    (self: super: {
      zigbee2mqtt = super.zigbee2mqtt.overrideAttrs (old: rec {
        version = "1.21.0";
        src = pkgs.fetchFromGitHub {
          owner = "Koenkk";
          repo = "zigbee2mqtt";
          rev = version;
          sha256 = "064qn970pqw07gdwy0jmhjgwi3qn1wiv81313zrcrpnprirkicd9";
        };
      });
    })
  ];

  services.zigbee2mqtt = {
    enable = true;
    package = pkgs.zigbee2mqtt;
    settings = {
      homeassistant = config.services.home-assistant.enable;
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

  services.home-assistant = {
    #package = (pkgs.unstable.home-assistant.override {
    #  extraComponents =  [
    #    pkgs.pythonPackages.sqlalchemy
    #  ];
    #});
    enable = false;
    #configWritable = true;
  };

}
