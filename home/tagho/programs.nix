{pkgs, ...}: {
  home.packages = with pkgs; [
    neofetch
    unstable.vscode
    nil
    nixpkgs-fmt
    libsForQt5.discover
    vivaldi
    vulkan-tools
    glxinfo
  ];

  programs.git = {
    enable = true;
    userName = "Joshua Tag Howard";
    userEmail = "jtho264@uky.edu";
  };
}
