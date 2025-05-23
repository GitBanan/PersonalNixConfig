{lib, ...}: {
  i18n = {
    defaultLocale = lib.mkDefault "en_GB.UTF-8";
    extraLocaleSettings = {
      LC_TIME = lib.mkDefault "en_IN";
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
