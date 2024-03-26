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
    steamtinkerlaunch
    firefox
    nvidia-vaapi-driver
    winetricks
    protontricks
    lutris
  ];

  programs.git = {
    enable = true;
    userName = "Joshua Tag Howard";
    userEmail = "jtho264@uky.edu";
  };

  services.ssh-agent.enable = true;
}
