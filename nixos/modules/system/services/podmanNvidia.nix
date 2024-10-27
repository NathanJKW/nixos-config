# NixOS Module: Podman with NVIDIA Support
# ----------------------------------------
# This module provides an option to enable Podman with NVIDIA GPU support. 
# The settings allow Podman to operate in Docker-compatible mode, making it 
# easier to run Docker-compliant images and configurations within Podman.
#
# Note: This configuration assumes certain packages and settings are defined 
# in `networking.nix`.

{ config, pkgs, lib, ... }:

{
  # Define custom options for enabling Podman with NVIDIA support
  options = {
    myModules.podman.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Podman with Nvidia support";
    };
  };

  # Conditional configuration applied only when `myModules.podman.enable` is set to `true`
  config = lib.mkIf config.myModules.podman.enable {
    # Enables NixOS container support, using Podman as the container backend
    virtualisation.containers.enable = true;

    # Podman settings
    virtualisation.podman = {
      enable = true;                                # Activate Podman service
      dockerCompat = true;                          # Allows Podman to work as a Docker alternative, supporting Docker-compatible commands
      defaultNetwork.settings.dns_enabled = true;   # Enables DNS for `podman-compose` compatibility <- these 
    };

    # NVIDIA Container Toolkit for GPU passthrough support
    hardware.nvidia-container-toolkit.enable = true;
  };
}

# Information on Podman and Usage Notes
# -------------------------------------
# Containers
# ----------
#
# ## Podman vs Docker
# Podman was chosen over Docker due to its simpler setup and compatibility 
# with my configuration. Docker compatibility is still enabled within Podman 
# to facilitate Docker-based workflows and image usage.
#
# ## Additional Packages in `networking.nix`
# As per setup instructions, additional packages required for networking 
# and container functionality were added in `networking.nix`. While this 
# configuration is functional, a thorough verification of these dependencies 
# may be necessary to confirm their necessity in the future.
# defaultNetwork.settings.dns_enabled = true; <-- packages are for this I think
