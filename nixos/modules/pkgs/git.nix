{ config, pkgs, lib, ... }:

{
  options = {
    myModules.git.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable git with recommended packages and settings.";
    };
  };

  config = lib.mkIf config.myModules.git.enable {
    # Enable Git package installation
    environment.systemPackages = with pkgs; [
      git
    ];

    # Add .gitconfig with user settings to /etc
    environment.etc."gitconfig" = {
      text = ''
        [user]
          name = "Nathan Wilson"
          email = "NathanJKWilson@outlook.com"
        [core]
          editor = "nano"  # Change to your preferred editor
      '';
    };
  };
}