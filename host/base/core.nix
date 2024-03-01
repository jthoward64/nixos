{...}: {
  # Set your time zone.
  time.timeZone = "America/New_York";

  nix.settings.experimental-features = ["nix-command" "flakes"];

  nixpkgs.config.allowUnfree = true;
}
