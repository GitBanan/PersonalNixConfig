{lib, ...}: {
  i18n = {
    defaultLocale = lib.mkDefault "en_GB.UTF-8";
    extraLocaleSettings = {
      LC_TIME = lib.mkDefault "en_IN";

      #TODO: To be tested for differences
      # LC_ADDRESS = "en_IN";
      # LC_IDENTIFICATION = "en_IN";
      # LC_MEASUREMENT = "en_IN";
      # LC_MONETARY = "en_IN";
      # LC_NAME = "en_IN";
      # LC_NUMERIC = "en_IN";
      # LC_PAPER = "en_IN";
      # LC_TELEPHONE = "en_IN";
    };
    supportedLocales = lib.mkDefault [
      "en_US.UTF-8/UTF-8"
      "en_GB.UTF-8/UTF-8"
      "en_IN/UTF-8"
    ];
  };
  location.provider = "geoclue2";
  time.timeZone = lib.mkDefault "Asia/Kolkata";
}
