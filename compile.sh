#!/bin/sh

cd /home/jee/MainDirectory/PC/Linux/Nix/nix-config/
sudo nix flake update
sudo nixos-rebuild switch --flake .#nixos
