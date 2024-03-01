#!/bin/sh
set -e
pushd /etc/nixos
alejandra . &
>/dev/null
git diff -U0 *.nix
echo "NixOS Rebuilding..."
sudo nixos-rebuild switch &
>nixos-switch.log || (
  cat nixos-switch.log | grep --color error && false
)
gen=$(nixos-rebuild list-generations | grep current)
git commit -am "Generation $gen"
popd
