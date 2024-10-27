# Setting Up NixOS with Repository Configuration Files

To configure NixOS using the files in this repository, we will create a symbolic link from the repository’s configuration folder to the default `/etc/nixos` directory.

## Steps:

1. **Add Unstable Channel and Remove the Default NixOS Configuration Directory**
   ```bash
   sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
   sudo nix-channel --update
   sudo rm -r /etc/nixos
   ```

2. **Create a Symbolic Link to the Repository Configuration**

**Dont use releative paths**

   ```bash
   # General form
   sudo ln -s <Repo Folder> </etc/nixos>
   # Example
   sudo ln -s ~/Documents/nixos-config/nixos/ /etc/nixos
   ```

3. **Verify the Link**
   ```bash
   ls -l /etc/nixos
   ```

4. **Rebuild**
   ```bash
   sudo nixos-rebuild switch
   ```

This setup will ensure that NixOS uses the configuration files stored in your repository.

# Config files structure

/etc/nixos/
├── configuration.nix            # Main entry file that imports all modules and configurations
├── hardware-configuration.nix    # Auto-generated hardware settings (do not modify manually)
├── secrets.nix                   # Sensitive data (consider secure storage or encrypted methods if used)
│
├── modules/                      # Organized configuration modules
│   ├── system/                   # System-wide configurations
│   │   ├── networking.nix        # Network settings, including DNS and firewall configurations
│   │   ├── users.nix             # User management and permissions
│   │   ├── hardware/             # Hardware-specific configurations
│   │   │   ├── gpu.nix           # GPU and passthrough configurations (e.g., NVIDIA, GPU drivers)
│   │   │   └── input.nix         # Input devices like keyboards, mice, and touchpads
│   │   ├── services/             # System services and daemons
│   │   │   ├── docker.nix        # Docker service with GPU passthrough configurations
│   │   │   └── virtualization.nix # Virtualization settings (e.g., KVM, QEMU)
│   │   ├── logging.nix           # System logging configurations (e.g., journalctl, rsyslog)
│   │   └── custom/               # Custom scripts and environment settings
│   │       ├── aliases.nix       # Custom shell aliases for convenience
│   │       └── environment.nix   # Environment variables for system-wide access
│   │
│   ├── desktop/                  # Desktop environment and user interface configurations
│   │   ├── display.nix           # Display and monitor configurations (e.g., resolution, multi-monitor setups)
│   │   ├── notifications.nix     # Notification daemon settings
│   │   └── appearance.nix        # Appearance configurations, including themes, fonts, and wallpapers
│   │
│   ├── pkgs/                     # Package installation 1 file per package which handles install and config
│   │   ├── brave.nix            # Main packages imported from the stable channel
│   │   └── unstable.nix          # Packages imported specifically from the unstable channel
│
└── overlays/                     # Custom package overlays for Nix
    └── custom-overlay.nix        # Define custom versions, modifications, or package overlays here
