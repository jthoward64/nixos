{pkgs, ...}: {
  home.packages = with pkgs; [
    neofetch
    vscode
    nil
    nixpkgs-fmt
    libsForQt5.discover
    vivaldi
    vulkan-tools
    glxinfo
    thunderbird
    libsForQt5.kate
  ];

  programs.git = {
    enable = true;
    userName = "Joshua Tag Howard";
    userEmail = "jtho264@uky.edu";
  };
}
