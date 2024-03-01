{...}: {
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  fonts.fontDir.enable = true;

  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
}
