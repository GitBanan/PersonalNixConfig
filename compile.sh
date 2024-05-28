#!/usr/bin/env bash

# Sudo
# [ "$UID" -eq 0 ] || exec sudo bash "$0" "$@"

cd /home/jee/MainDirectory/PC/Linux/Nix/nix-config/ || exit

# Git
if [[ "$1" =~ 'g' ]]; then
    # sudo -u "$USER" gacp "$2"
    gacp "$2"
fi

if [[ "$1" =~ 'v' ]]; then
    nix-store --repair --verify --check-contents
fi

if [[ "$1" =~ 'u' ]]; then
    nix flake update
fi

if [[ "$1" =~ 'h' ]]; then
    home-manager switch --flake .#jee@nixos
else
    sudo nixos-rebuild switch --flake .#nixos
fi
