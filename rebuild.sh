#!/usr/bin/env bash

# Authenticate

sudo echo "Ready"

# Setup
set -e
pushd /etc/nixos

# Formatting
alejandra . &>/dev/null

# Diff
git diff -U0 *.nix

# Confirm Rebuild
read -p "Rebuild NixOS? [y/N] " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo "Aborted."
  exit 1
fi

# Rebuild
rebuildArgs=""
# Allow passing --upgrade to nixos-rebuild
if [[ $2 == "--upgrade" ]]; then
  echo "Upgrading..."
  rebuildArgs="--upgrade"
  nix flake update
fi
echo "NixOS Rebuilding..."
sudo nixos-rebuild $1 $rebuildArgs &>nixos-switch.log || (
  cat nixos-switch.log | grep --color error && false
)

genString=$(nixos-rebuild list-generations | grep current)

currentGen=$(echo $genString | awk '{print $1}')
lastGen=$(echo $currentGen | awk '{print $1-1}')

# Print the diff-closures between the current and previous generation
echo "Changes made in this generation:"
nix store diff-closures "/nix/var/nix/profiles/system-$lastGen-link" "/nix/var/nix/profiles/system-$currentGen-link"

# Ask if we want to rollback or commit
rollbackOrCommit=""
while [[ $rollbackOrCommit != "r" && $rollbackOrCommit != "c" ]]; do
  read -p "Rollback or Commit? [r/c] " -n 1 -r
  echo
  rollbackOrCommit=$REPLY
done

# Rollback
if [[ $rollbackOrCommit == "r" ]]; then
  echo "Rolling back..."
  sudo nixos-rebuild switch --rollback
  exit 1
fi

# Commit
echo "Committing..."
git commit -am "$genString"
popd
