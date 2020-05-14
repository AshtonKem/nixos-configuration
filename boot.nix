{ config, pkgs, ...}:
{
  boot.loader.grub =
  {
    enable = true;
    version = 2;
    device = "/dev/sda";
    useOSProber = true;
  };
  boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];
  boot.initrd.kernelModules = [ "wl" ];
}
