{ config, pkgs, lib, ... }:

{
  options = {
    # Option to enable or disable this module
    myModules.vscode-nix-setup.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable VS Code with Nix extensions and recommended settings.";
    };
  };

  config = lib.mkIf config.myModules.vscode-nix-setup.enable {
    # Ensure VS Code, extensions, and dependencies are installed
    environment.systemPackages = with pkgs; [
      vscode         # VS Code installation
      nil            # Alternative Nix Language Server for IDE support
      direnv         # Direnv for environment management in VS Code
    ];

    # VS Code configuration with Nix Language Server enabled
    environment.etc."vscode/settings.json".text = ''
      {
        "nix.enableLanguageServer": true,
        "nix.serverPath": "nil"
      }
    '';

    # Enable direnv integration
    programs.direnv = {
      enable = true;
      #enableFlakes = true;  # Enable if you use flakes
    };

    # Set Wayland support if needed
   # environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
