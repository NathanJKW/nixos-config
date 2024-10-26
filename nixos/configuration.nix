{ config, pkgs, ... }:
let
  # Define the unstable channel
  unstable = import <nixos-unstable> { config = config.nixpkgs.config; };
in
{
  imports =
    [
      ./hardware-configuration.nix
      ./modules/system/boot/systemmd.nix
      ./modules/system/kernel/linuxKernel_6_10.nix
      ./modules/system/hardware/nvidiaDriver_555_58_02.nix
      ./modules/system/hardware/soundPulse.nix
      ./modules/system/hardware/printerCUPS.nix
      ./modules/system/services/dockerNvidia.nix
      ./modules/system/userSettings.nix
      ./modules/system/networking.nix
      ./modules/desktop/gnomeDesktop.nix
      ./modules/pkgs/cursor.nix
      ./modules/pkgs/git.nix
      ./modules/pkgs/vscode.nix

    ];
  
  # not sure where best to put this....
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # Enable/Disable Modules
  myModules.systemmd.enable = true;
  myModules.linuxKernel_6_10.enable = true;
  myModules.nvidiaDriver_555_58_02.enable = true;
  myModules.soundPulse.enable = true;
  myModules.printerCUPS.enable = true;
  myModules.dockerNvidia.enable = true;
  myModules.userSettings.enable = true;
  myModules.networking.enable = true;
  myModules.gnomeDesktop.enable = true;
  
  myModules.cursor.enable = true;
  myModules.vscode.enable = true;
  myModules.git.enable = true;

  
  

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  brave
  #vscode
  unstable.code-cursor
  ];



  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  system.stateVersion = "24.05";
}
