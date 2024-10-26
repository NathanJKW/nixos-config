{ config, pkgs, lib, ... }:

{
  options = {
    myModules.onlyOffice.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable onlyOffice with recommended packages and settings.";
    };
  };

  config = lib.mkIf config.myModules.onlyOffice.enable {
    # Enable onlyOffice package installation
    environment.systemPackages = with pkgs; [
      onlyoffice-bin
    ];
  };
}