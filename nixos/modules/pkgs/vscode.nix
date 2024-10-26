{ config, pkgs, lib, ... }:

{
  options = {
    myModules.vscode.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable vscode with recommended packages and settings.";
    };
  };

  config = lib.mkIf config.myModules.vscode.enable {
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
  };
}