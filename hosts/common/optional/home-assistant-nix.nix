{
  pkgs,
  config,
  inputs,
  ...
}: {
  # Use unstable package for HAss
  imports = [
    "${inputs.nixpkgs-unstable}/nixos/modules/services/home-automation/home-assistant.nix"
  ];
  disabledModules = [
    "services/home-automation/home-assistant.nix"
  ];

  services.home-assistant = {
    enable = true;
    openFirewall = true;
    package = pkgs.unstable.home-assistant;    

    extraComponents = [
      # Components required to complete the onboarding
      "analytics"
      "google_translate"
      "met"
      "radio_browser"
      "shopping_list"
      # Recommended for fast zlib compression
      # https://www.home-assistant.io/integrations/isal
      "isal"

      # Installed devices
      "esphome"
      "hikvision"
      "hikvisioncam"
    ];

    config = {
      # Includes dependencies for a basic setup
      # https://www.home-assistant.io/integrations/default_config/
      #default_config = {};
      #homeassistant = {
        # MUST be at the top or will break entire configuration
        # Declare all "entity_id" objects here at this level to customize them
        binary_sensor = [ 
	  {
            platform = "hikvision";
            host = "192.168.29.107";
            port = "80";
    	    ssl = "false";
    	    username = builtins.readFile config.sops.secrets.hikvision-user.path;
    	    password = builtins.readFile config.sops.secrets.hikvision-password.path;
	    customize = {
      	      motion = {
                delay = "10";
      	      };
      	      line_crossing = {
                ignored = "false";
      	      };
	    };
	  }
	];
      #};
    };
  };
}
