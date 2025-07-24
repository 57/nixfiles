{ config, pkgs, lib, ... }:
{
  home.username = "fawn";
  home.homeDirectory = "/home/fawn";
  home.stateVersion = "25.05";

  imports = [
    ../modules/hyprland.nix
    ../modules/waybar.nix
    ../modules/zsh.nix
    ./ui.nix
    ./packages.nix
  ];
} 