{ pkgs, ... }:

{
  home.packages = with pkgs; [
    neofetch
    vscode
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
