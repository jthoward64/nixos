{pkgs, ...}: {
  home.packages = with pkgs; [
    neofetch
    unstable.vscode
    nil
    nixpkgs-fmt
    kdePackages.discover
    vulkan-tools
    glxinfo
    thunderbird
    kdePackages.kate
    htop
    papirus-icon-theme
    jetbrains.datagrip
    android-studio
    nushell
    nvidia-vaapi-driver
    winetricks
    protontricks
    lutris
    wineWow64Packages.full
    jetbrains.idea-community
    steam-run
  ];

  programs.git = {
    enable = true;
    userName = "Joshua Tag Howard";
    userEmail = "tag@jthoward.dev";
  };

  services.ssh-agent.enable = true;
}
