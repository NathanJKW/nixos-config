{ config, pkgs, lib, ... }:

{
  options = {
    # Option to enable or disable this generic module
    myModules.networking.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable networking with recommended packages and settings.";
    };
  };

  config = lib.mkIf config.myModules.networking.enable {
    networking.hostName = "ziggy"; # Define your hostname.
    networking.networkmanager.enable = true;
    
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  
    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;
  };
}