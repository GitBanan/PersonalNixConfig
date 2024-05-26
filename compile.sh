#!/usr/bin/env bash

cd /home/jee/MainDirectory/PC/Linux/Nix/nix-config/

# Git
if [[ "$1" =~ 'g' ]]; then
    gacp $2
fi

# Sudo
# [ "$UID" -eq 0 ] || exec sudo bash "$0" "$@"

if [[ "$1" =~ 'v' ]]; then
    sudo nix-store --repair --verify --check-contents
fi

if [[ "$1" =~ 'u' ]]; then
    nix flake update
fi

if [[ "$1" =~ 'h' ]]; then
    home-manager switch --flake .#jee@nixos
else
    sudo nixos-rebuild switch --flake .#nixos #--show-trace
fi
