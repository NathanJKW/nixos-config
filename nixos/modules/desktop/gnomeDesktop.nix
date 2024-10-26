{ config, pkgs, lib, ... }:

{
  options = {
    # Option to enable or disable this generic module
    myModules.gnomeDesktop.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Gnome Desktop with recommended packages and settings.";
    };
  };

  config = lib.mkIf config.myModules.gnomeDesktop.enable {
    # Enable the X11 windowing system.
    services.xserver.enable = true;
    
    # Enable the GNOME Desktop Environment.
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;

  };
}