# NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./hardware-configuration.nix                        # Hardware Scan
      ./nvidia.nix                                        # Nvidia Setup
    ];
#  boot.kernelPackages = pkgs.linuxPackagesFor (pkgs.linux_6_10.override {
#    argsOverride = rec {
#      src = pkgs.fetchurl {
#        url = "mirror://kernel/linux/kernel/v6.x/linux-${version}.tar.xz";
#        sha256 = "900d567ff01824708ce24c3b37faaef03e6f6145411dd447a6ff2edc8c5db3a9";
#      };
#      version = "6.10.7";
#      modDirVersion = "6.10.7";
#    };
#  });
  

  boot.kernelPackages = pkgs.linuxPackages_6_10;
 
 # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;                

  # Time & Language setup
  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };



  ## Enable the GNOME Desktop Environment.
  ### GDM is the login screen
  #services.xserver.displayManager.gdm.enable = true;
  #services.xserver.displayManager.gdm.wayland = false;

  ### Gnome Desktop Enviroment
  #services.xserver.desktopManager.gnome.enable = true;
  #programs.hyprland.enable = true;
  services={
    xserver = {
      enable = true;
      xkb = {
        layout = "gb";
        variant = "";
      };
      displayManager = {
        gdm = {
          enable = true;
          wayland = true;
        };
      };
      desktopManager = {
        gnome = {
          enable = true;
        };
      };
    };
  };

  ### Configure console keymap
  console.keyMap = "uk";

  ## Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nathan = {
    isNormalUser = true;
    description = "Nathan";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # Programs
  ## Install firefox.
  programs.firefox.enable = true;

  # System Packages
  environment.systemPackages = with pkgs; [
  lshw
  git
  vscode
  kitty
  pkg-config
  gtk3
  vulkan-headers
  vulkan-loader
  vulkan-tools
  vulkan-validation-layers
  ];

  # This value determines the NixOS release
  system.stateVersion = "24.05";

}
