{pkgs, ...}: {
  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [xdg-desktop-portal-kde];
  xdg.portal.config.common.default = "kde";

  networking.networkmanager.enable = true;

  # Enable the Plasma 5 Desktop Environment.
  services.xserver.desktopManager.plasma5.enable = true;
  # services.xserver.displayManager.defaultSession = "plasmax11";

  programs.dconf.enable = true;

  boot.plymouth = {
    enable = true;
    theme = "breeze";
  };

  services.xserver.displayManager.sddm = {
    enable = true;
    theme = "breeze";
    autoNumlock = true;
  };
}
