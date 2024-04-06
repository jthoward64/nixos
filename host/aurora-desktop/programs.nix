{pkgs, ...}: {
  # Cloudflare
  services.cloudflared.enable = true;

  # Flatpak
  services.flatpak.enable = true;

  # Tailscale
  services.tailscale.enable = true;
  services.tailscale.extraUpFlags = ["--accept-dns" "--accept-routes"];
  services.tailscale.openFirewall = true;
  services.tailscale.authKeyFile = "/etc/nixos/secret/tailscale";

  environment.systemPackages = with pkgs; [
    libsForQt5.kio
    libsForQt5.kio-admin
    libsForQt5.kio-extras
    kio-fuse
    pkgs.postgresql_16
  ];

  virtualisation = {
    libvirtd.enable = true;
  };

  programs.virt-manager.enable = true;

  programs.gamescope.enable = true;

  programs.firefox = {
    enable = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  };

  services.teamviewer.enable = true;
}
