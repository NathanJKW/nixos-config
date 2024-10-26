{ config, pkgs, lib, ... }:

{
  options = {
    myModules.thunderbird.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable thunderbird with recommended packages and settings.";
    };
  };

  config = lib.mkIf config.myModules.thunderbird.enable {
    # Ensure VS Code, extensions, and dependencies are installed
    environment.systemPackages = with pkgs; [
      thunderbird         # VS Code installation
    ];
  };
}