{ config, pkgs, lib, ... }:

{
  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
  
  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];
  
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.beta;
    #package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
    #  version = "560.31.02";
     # sha256_64bit = "sha256-0cwgejoFsefl2M6jdWZC+CKc58CqOXDjSi4saVPNKY0=";
    #  sha256_aarch64 = "sha256-m7da+/Uc2+BOYj6mGON75h03hKlIWItHORc5+UvXBQc=";
    #  openSha256 = "sha256-X5UzbIkILvo0QZlsTl9PisosgPj/XRmuuMH+cDohdZQ=";
    #  settingsSha256 = "sha256-A3SzGAW4vR2uxT1Cv+Pn+Sbm9lLF5a/DGzlnPhxVvmE=";
    #  persistencedSha256 = "sha256-BDtdpH5f9/PutG3Pv9G4ekqHafPm3xgDYdTcQumyMtg=";
    #};
    # Use Nvidia Prime to choose which GPU (iGPU or eGPU) to use.
    prime = {
        sync.enable = true;
        allowExternalGpu = true;

        # Make sure to use the correct Bus ID values for your system!
        nvidiaBusId = "PCI:59:0:0";
        intelBusId = "PCI:0:2:0";
    };
  };
}
