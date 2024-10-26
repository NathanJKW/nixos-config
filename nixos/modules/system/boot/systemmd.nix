{ config, pkgs, lib, ... }:

{
  options = {
    # Option to enable or disable this generic module
    myModules.systemmd.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable systemmd with recommended packages and settings.";
    };
  };

  config = lib.mkIf config.myModules.systemmd.enable {
    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
  };
}