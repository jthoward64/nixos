{...}: {
  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "btrfs";

  users.users.tagho = {
    isNormalUser = true;
    extraGroups = ["wheel" "docker"];
  };

  networking.firewall = {
    trustedInterfaces = ["tailscale0" "docker0"];
  };
}
