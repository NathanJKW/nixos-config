{ config, pkgs, lib, ... }:

{
  options = {
    # Option to enable or disable this generic module
    myModules.soundPulse.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable soundPulse with recommended packages and settings.";
    };
  };

  config = lib.mkIf config.myModules.soundPulse.enable {
    # Enable sound with pipewire.
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;
  
      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };
  };
}