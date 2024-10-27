# NixOS Module: Networking Configuration
# --------------------------------------
# This module provides a configurable setup for networking, including hostname definition,
# NetworkManager, recommended system packages, and options for firewall and NAT (Network Address Translation).
# Set `myModules.networking.enable` to `true` to activate this module.

{ config, pkgs, lib, ... }:

{
  options = {
    # Option to enable or disable the networking module
    myModules.networking.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable networking with recommended packages and settings.";
    };
  };

  config = lib.mkIf config.myModules.networking.enable {
    # Basic Network Settings
    # ----------------------
    networking.hostName = "ziggy";                     # Defines the system's hostname
    networking.networkmanager.enable = true;           # Enables NetworkManager for managing network connections

    # System Packages
    # ---------------
    # Installs recommended packages for network functionality.
    # - `gnomeExtensions.ip-finder`: GNOME extension to locate IP addresses
    # - `cni-plugins`: Required for Podman networking
    # - `dnsname-cni`: Additional plugin for Podman DNS configuration
    
    environment.systemPackages = with pkgs; [
      gnomeExtensions.ip-finder
      cni-plugins                                     # Podman networking plugins
      dnsname-cni                                     # DNS plugin for Podman
    ];

    # Firewall Configuration (Optional)
    # ---------------------------------
    # Enables firewall and allows specific TCP ports if needed.
    # Uncomment `networking.firewall` settings to customize firewall behavior.
    
    # networking.firewall = {
    #   enable = true;                                # Enables the firewall
    #   allowedTCPPorts = [ 11434 ];                  # Opens specific TCP ports, e.g., for container access
    #   allowedUDPPorts = [ ... ];
    # };
    # networking.firewall.enable = false;             # Alternative: disable the firewall

    # Network Address Translation (NAT)
    # ---------------------------------
    # Enable NAT, especially useful when running Docker or Podman containers.
    networking.nat.enable = true;

    # Wireless Support (Optional)
    # ---------------------------
    # Uncomment to enable wireless support via `wpa_supplicant`.
    # networking.wireless.enable = true;

    # Proxy Configuration (Optional)
    # ------------------------------
    # Configure network proxies if needed. Replace `user`, `password`, `proxy`, and `port` accordingly.
    # networking.proxy.default = "http://user:password@proxy:port/"; # Set global proxy
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain"; # Exclude specific domains from proxy
  };
}
