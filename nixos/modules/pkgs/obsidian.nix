{ config, pkgs, lib, ... }:

{
  options = {
    myModules.obsidian.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable obsidian with recommended packages and settings.";
    };
  };

  config = lib.mkIf config.myModules.obsidian.enable {
    environment.systemPackages = with pkgs; [
      obsidian
    ];
  };
}