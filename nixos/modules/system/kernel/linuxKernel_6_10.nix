{ config, pkgs, lib, ... }:

{
  options = {
    # Option to enable or disable this generic module
    myModules.linuxKernel_6_10.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable linuxKernel_6_10 with recommended packages and settings.";
    };
  };

  config = lib.mkIf config.myModules.linuxKernel_6_10.enable {
    # Linux Kernal
    boot.kernelPackages = pkgs.linuxPackages_6_10;
  };
}