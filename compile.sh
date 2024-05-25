#!/usr/bin/env bash

cd /home/jee/MainDirectory/PC/Linux/Nix/nix-config/

if [[ "$1" =~ 'g' ]]; then
    gacp "$2"
fi

# Sudo
[ "$UID" -eq 0 ] || exec sudo bash "$0" "$@"

if [[ "$1" =~ 'v' ]]; then
    nix-store --repair --verify --check-contents
fi

if [[ "$1" =~ 'u' ]]; then
    nix flake update
fi

nixos-rebuild switch --flake .#nixos --show-trace

# home-manager --flake .#nixos
