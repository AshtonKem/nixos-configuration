{ config, pkgs, ... }:
{
  # Enable Locking of the screen
  services.physlock = {
    allowAnyUser = true;
    enable = true;
  };

  # X11
  services.xserver = {
    enable = true;
    layout = "us";
    videoDrivers = [ "nvidia"];
    windowManager = {
      i3.enable = true;
    };

    displayManager = {
      lightdm.enable = true;
    };

    xautolock = {
      enable = true;
      enableNotifier = true;
      locker = ''${config.security.wrapperDir}/physlock'';
      notifier = ''${pkgs.libnotify}/bin/notify-send "Locking in 10 seconds"'';
    };
  };
}
