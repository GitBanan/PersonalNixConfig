#!/usr/bin/env bash

cd /home/jee/MainDirectory/PC/Linux/Nix/nix-config/
# sudo nix flake update
sudo nixos-rebuild switch --flake .#nixos --show-trace
# sudo nixos-rebuild switch --update-input nixpkgs --flake .#nixos
# sudo home-manager --flake .#nixos

#sudo nix-store --repair --verify --check-contents
