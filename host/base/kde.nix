{pkgs, ...}: {
  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [xdg-desktop-portal-kde];
  xdg.portal.config.common.default = "kde";

  networking.networkmanager.enable = true;

  # Enable the Plasma 5 Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma6.enable = true;
  services.xserver.displayManager.defaultSession = "plasmax11";

  programs.dconf.enable = true;
}
