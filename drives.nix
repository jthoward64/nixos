{ ... }:

{
  # Minimal list of modules to use the EFI system partition and the YubiKey
  boot.initrd.kernelModules = [ "vfat" "nls_cp437" "nls_iso8859-1" "usbhid" ];

  # Enable support for the YubiKey PBA
  boot.initrd.luks.yubikeySupport = true;

  # Configuration to use the Luks devices
  boot.initrd.luks.devices = {
    "drive0-enc" = {
      device = "/dev/disk/by-uuid/266e1760-adbd-4082-a870-7cbd43162ee4";
      preLVM = true;
      yubikey = {
        slot = 2;
        twoFactor = false;
        storage = {
          device = "/dev/disk/by-uuid/375E-ECEE";
        };
      };
    };
    "drive1-enc" = {
      device = "/dev/disk/by-uuid/08512800-6f2c-4981-a0f7-ea31c91da883";
      preLVM = true;
      yubikey = {
        slot = 2;
        twoFactor = false;
        storage = {
          device = "/dev/disk/by-uuid/D7E0-7A48";
        };
      };
    };
  };

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/41712790-4ec7-42c9-86ea-bc69a694df11";
      fsType = "btrfs";
      options = [ "compress=zstd" "noatime" "subvol=@" ];
    };

  fileSystems."/home" =
    {
      device = "/dev/disk/by-uuid/41712790-4ec7-42c9-86ea-bc69a694df11";
      fsType = "btrfs";
      options = [ "compress=zstd" "noatime" "subvol=@home" ];
    };

  fileSystems."/nix" =
    {
      device = "/dev/disk/by-uuid/41712790-4ec7-42c9-86ea-bc69a694df11";
      fsType = "btrfs";
      options = [ "compress=zstd" "noatime" "subvol=@nix" ];
    };

  fileSystems."/swap" =
    {
      device = "/dev/disk/by-uuid/41712790-4ec7-42c9-86ea-bc69a694df11";
      fsType = "btrfs";
      options = [ "noatime" "subvol=@swap" ];
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/D7E0-7A48";
      fsType = "vfat";
    };

  swapDevices = [{ device = "/swap/swapfile"; }];
}
