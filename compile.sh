#!/usr/bin/env bash

# Sudo
# [ "$UID" -eq 0 ] || exec sudo bash "$0" "$@"

cd /home/jee/Nix/PersonalNixConfig/ || exit

git_comment=''
host="$HOSTNAME" || host=''
home_flag='false'
update_flag='false'
verify_flag='false'

while getopts 'g:h:Huv' flag; do
  case "${flag}" in
    g) git_comment="${OPTARG}" ;;
    h) host="${OPTARG}" ;;
    H) home_flag='true' ;;
    u) update_flag='true' ;;
    v) verify_flag='true' ;;
    *) echo "Setting up ${HOME}" || exit
       exit 1 ;;
  esac
done

# Git
if [[ "$git_comment" != '' ]]; then
    # sudo -u "$USER" gacp "$2"
    git add .
    git commit -am "$git_comment"
    git push
fi

if [[ "$verify_flag" == 'true' ]]; then
    nix-store --repair --verify --check-contents
fi

if [[ "$update_flag" == 'true' ]]; then
    nix flake update
fi

nixos-rebuild --flake .\#$host switch --target-host $host --use-remote-sudo

if [[ "$home_flag" == 'true' ]]; then
    home-manager --flake switch .#jee@$host
fi
