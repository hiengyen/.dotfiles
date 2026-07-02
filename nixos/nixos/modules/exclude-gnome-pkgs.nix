{ pkgs, ... }:

{
  ## Remove unuse pkg, service on NixOS Gnome
  environment.gnome.excludePackages = with pkgs; [
    gnome-connections
    nixos-render-docs
    gnome-software
    gnome-music
    gnome-contacts
    gnome-maps
    gnome-weather
    cheese
    epiphany # web browser
    geary
    totem
    xterm
    gnome-tour
    gnome-user-docs
  ];
  ##
}
