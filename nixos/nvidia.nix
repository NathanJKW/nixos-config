{ config, pkgs, lib, ... }:

{
 # Enable OpenGL
  hardware.opengl = {
    enable = true;
    #driSupport = true;
    #driSupport32Bit = true;
  };
  
  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];
  
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;

#    package = config.boot.kernelPackages.nvidiaPackages.latest;
    package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
      version = "555.58.02";
      sha256_64bit = "sha256-xctt4TPRlOJ6r5S54h5W6PT6/3Zy2R4ASNFPu8TSHKM=";
      sha256_aarch64 = "sha256-xctt4TPRlOJ6r5S54h5W6PT6/3Zy2R4ASNFPu8TSHKM=";
      openSha256 = "sha256-ZpuVZybW6CFN/gz9rx+UJvQ715FZnAOYfHn5jt5Z2C8=";
      settingsSha256 = "sha256-ZpuVZybW6CFN/gz9rx+UJvQ715FZnAOYfHn5jt5Z2C8=";
      persistencedSha256 = lib.fakeSha256;
    };
#    package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
#      version = "555.58.02";
#      sha256_64bit = "sha256-xctt4TPRlOJ6r5S54h5W6PT6/3Zy2R4ASNFPu8TSHKM=";
 #     sha256_aarch64 = "sha256-xctt4TPRlOJ6r5S54h5W6PT6/3Zy2R4ASNFPu8TSHKM=";
#      openSha256 = "sha256-ZpuVZybW6CFN/gz9rx+UJvQ715FZnAOYfHn5jt5Z2C8=";
 #     settingsSha256 = "sha256-ZpuVZybW6CFN/gz9rx+UJvQ715FZnAOYfHn5jt5Z2C8=";
#      persistencedSha256 = lib.fakeSha256;
#    };
    # Use Nvidia Prime to choose which GPU (iGPU or eGPU) to use.
    prime = {
        sync.enable = true;
        allowExternalGpu = true;

        # Make sure to use the correct Bus ID values for your system!
        nvidiaBusId = "PCI:01:00:0";
        intelBusId = "PCI:0:2:0";
    };
  };
}
