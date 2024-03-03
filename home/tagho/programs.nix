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
  ];

  programs.git = {
    enable = true;
    userName = "Joshua Tag Howard";
    userEmail = "jtho264@uky.edu";
  };
}
