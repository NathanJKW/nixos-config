{ config, lib, pkgs, ... }:
{
  virtualisation.docker = {
      enable = true;
      enableOnBoot = true;
      package = pkgs.docker_25;
  };

  hardware.nvidia-container-toolkit.enable = true;
}

# docker run --rm --device nvidia.com/gpu=all ubuntu:latest nvidia-smi
# https://discourse.nixos.org/t/nvidia-docker-container-runtime-doesnt-detect-my-gpu/51336

# With hardware.nvidia-container-toolkit.enable = true;
# the Container Device Interface (CDI) is used instead of the nvidia runtime wrappers.
# With CDI you have to specify the devices with the --device argument instead of the --gpus one, like this: