{ config, pkgs, ... }:

{
  imports = [
    # Core System Configuration
    ./hardware-configuration.nix
    ./modules/system/boot/systemmd.nix
    ./modules/system/kernel/linuxKernel_6_10.nix
    ./modules/system/hardware/nvidiaDriver_555_58_02.nix
    ./modules/system/hardware/soundPulse.nix
    ./modules/system/hardware/printerCUPS.nix
    ./modules/system/networking.nix
    ./modules/system/userSettings.nix

    # Services
    ./modules/system/services/dockerNvidia.nix

    # Desktop Environment
    ./modules/desktop/gnomeDesktop.nix

    # Packages
    ./modules/pkgs/cursor.nix
    ./modules/pkgs/git.nix
    ./modules/pkgs/vscode.nix
    ./modules/pkgs/onlyOffice.nix
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable/Disable Modules

  ## Core Modules
  myModules.systemmd.enable = true;
  myModules.linuxKernel_6_10.enable = true;
  myModules.nvidiaDriver_555_58_02.enable = true;
  myModules.soundPulse.enable = true;
  myModules.printerCUPS.enable = true;
  myModules.networking.enable = true;
  myModules.userSettings.enable = true;

  ## Services
  myModules.dockerNvidia.enable = true;

  ## Desktop Environment
  myModules.gnomeDesktop.enable = true;

  ## Packages
  myModules.cursor.enable = true;
  myModules.vscode.enable = true;
  myModules.git.enable = true;
  myModules.onlyOffice.enable = true;

  # System Packages
  environment.systemPackages = with pkgs; [
    brave
  ];
  
  environment.variables.GTK_THEME = "Adwaita:dark";

  # System State Version
  system.stateVersion = "24.05";

  # Example Program Configurations
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Example Services
  # services.openssh.enable = true;
}
