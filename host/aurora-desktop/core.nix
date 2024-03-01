{ ... }: {
  users.users.tagho = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
}
