{ config, pkgs, lib, ... }:

{
  options = {
    myModules.dockerNvidia.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Docker with Nvidia support";
    };
  };

  config = lib.mkIf config.myModules.dockerNvidia.enable {
    virtualisation.docker = {
      enable = true;
      enableOnBoot = true;
      package = pkgs.docker_25;
    };

    hardware.nvidia-container-toolkit.enable = true;
  };
}


# https://discourse.nixos.org/t/nvidia-docker-container-runtime-doesnt-detect-my-gpu/51336

# With hardware.nvidia-container-toolkit.enable = true;
# the Container Device Interface (CDI) is used instead of the nvidia runtime wrappers.
# With CDI you have to specify the devices with the --device argument instead of the --gpus one, like this:
# docker run --rm --device nvidia.com/gpu=all ubuntu:latest nvidia-smi