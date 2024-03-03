{pkgs, ...}: {
  home.packages = with pkgs; [
    neofetch
    unstable.vscode
    nil
    nixpkgs-fmt
    kdePackages.discover
    vivaldi
    vulkan-tools
    glxinfo
    thunderbird
    kdePackages.kate
    htop
  ];

  programs.git = {
    enable = true;
    userName = "Joshua Tag Howard";
    userEmail = "jtho264@uky.edu";
  };
}
