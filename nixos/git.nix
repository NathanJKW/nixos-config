{ config, pkgs, ... }:

{
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
}
