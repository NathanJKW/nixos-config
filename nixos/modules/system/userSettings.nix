{ config, pkgs, lib, ... }:

{
  options = {
    # Option to enable or disable this generic module
    myModules.userSettings.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable userSettings with recommended packages and settings.";
    };
  };

  config = lib.mkIf config.myModules.userSettings.enable {
    # Set your time zone.
    time.timeZone = "Europe/London";
  
    # Select internationalisation properties.
    i18n.defaultLocale = "en_GB.UTF-8";
  
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_GB.UTF-8";
      LC_IDENTIFICATION = "en_GB.UTF-8";
      LC_MEASUREMENT = "en_GB.UTF-8";
      LC_MONETARY = "en_GB.UTF-8";
      LC_NAME = "en_GB.UTF-8";
      LC_NUMERIC = "en_GB.UTF-8";
      LC_PAPER = "en_GB.UTF-8";
      LC_TELEPHONE = "en_GB.UTF-8";
      LC_TIME = "en_GB.UTF-8";
    };
  
    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "gb";
      variant = "";
    };
  
    # Configure console keymap
    console.keyMap = "uk";
  
    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.nathan = {
      isNormalUser = true;
      description = "Nathan";
      extraGroups = [ "networkmanager" "wheel" "docker" "podman" ];
      packages = with pkgs; [
      #  thunderbird
      ];
    };
  };
}