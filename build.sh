#!/usr/bin/env bash

set -e

echo "Staging files..."
git add .
git diff --staged --name-status

echo "NixOS rebuilding..."
sudo nixos-rebuild switch --flake . --impure &>nixos-switch.log || (
  bat nixos-switch.log | rg error && false
)

echo "Home Manager rebuilding..."
home-manager switch --flake . &>home-switch.log || (
  bat home-switch.log | rg error && false
)

echo "Generating git commit..."
gen="$(date --rfc-3339 s)\n\n$(nixos-rebuild list-generations | rg current)\n$(home-manager generations | head -1)"
git commit -am "$(echo -e $gen)" &>git.log || (
  bat git.log | rg error && false
)
git log -n1 --oneline
