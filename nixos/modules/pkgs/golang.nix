{ config, pkgs, lib, ... }:

{
  options = {
    myModules.golang.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable golang with recommended packages and settings.";
    };
  };

  config = lib.mkIf config.myModules.golang.enable {
    environment.systemPackages = with pkgs; [
      go
    ];
  };
}