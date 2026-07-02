{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> {
    config = {
      allowUnfree = true;
    };
  };
in
{
  environment.systemPackages = with pkgs; [
    unstable.code-cursor
    unstable.terraform # Infrastructure as Code
    unstable.vscode
    unstable.gnomeExtensions.clipboard-indicator
    unstable.anki-bin
    unstable.awscli2
    unstable.ssm-session-manager-plugin
    unstable.proton-vpn
    unstable.postman
    unstable.go
    unstable.gotools
    unstable.obsidian # Knowledge base and note-taking
    unstable.kiro
  ];

}
