{ config, pkgs, lib, ... }:
let
  # Define the unstable channel
  # TODO need to show/have a standard way to add unstable channel
  unstable = import <nixos-unstable> { config = config.nixpkgs.config; };
in
{
  options = {
    myModules.cursor.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable cursor with recommended packages and settings.";
    };
  };

  config = lib.mkIf config.myModules.cursor.enable {
    environment.systemPackages = with pkgs; [
    unstable.code-cursor
    ];
  };
}