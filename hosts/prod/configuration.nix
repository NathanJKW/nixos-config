{ config, pkgs, ... }:
{
  imports = [ ];

  # Basic system settings
  system.stateVersion = "24.05";
  networking.hostName = "prod-server";
  time.timeZone = "UTC";

  # Enable SSH with username/password login
  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = true;
  services.openssh.settings.PermitRootLogin = "no";

  # Firewall
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];

  # Users
  users.users.nathan = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    password = "809e914e1c8faf8b568c9be752de7ae436ac00c2805d189fb123db2f6d9dd96cc5fb4ef139e60b9ad9aef6b4082d8172735e620ff3968976e31367c48aa60738";
  };

  # Security
  security.sudo.wheelNeedsPassword = true;
  security.audit.enable = true;
  security.protectKernelImage = true;

  # Minimal set of packages
  environment.systemPackages = with pkgs; [
    vim
    git
    htop
    curl
  ];

  # Enable automatic upgrades
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = false;

  # Filesystems
  fileSystems."/" = {
    device = "/dev/sda1";
    fsType = "ext4";
  };

  # Bootloader for VirtualBox
  boot.loader.grub.enable = true;
  boot.loader.grub.devices = [ "/dev/sda" ];
}
