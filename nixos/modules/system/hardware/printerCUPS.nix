{ config, pkgs, lib, ... }:

{
  options = {
    # Option to enable or disable this generic module
    myModules.printerCUPS.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable printerCUPS with recommended packages and settings.";
    };
  };

  config = lib.mkIf config.myModules.printerCUPS.enable {
    # Enable CUPS to print documents.
   services.printing.enable = true;
  };
}