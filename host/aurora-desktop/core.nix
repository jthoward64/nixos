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

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
    openFirewall = true;
  };
}
