# Setting Up NixOS with Repository Configuration Files

To configure NixOS using the files in this repository, we will create a symbolic link from the repository’s configuration folder to the default `/etc/nixos` directory.

### Steps:

1. **Remove the Default NixOS Configuration Directory**
   ```bash
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

This setup will ensure that NixOS uses the configuration files stored in your repository.