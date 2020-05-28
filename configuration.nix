# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ./backup.nix
      ./boot.nix
      ./secrets.nix
      ./xserver.nix
      ./hardware-configuration.nix
    ];


  networking.networkmanager.enable = true;
  networking.hostName = "nixos"; # Define your hostname.
  services.openssh.permitRootLogin = "no";
  services.openssh.passwordAuthentication = false;
  services.openssh.enable = true;
  services.sshd.enable = true;
  services.redshift.enable = true;
  services.zookeeper.enable = true;


  # Set your time zone.
  time.timeZone = "America/Los_Angeles";
  services.lorri.enable = true;

  networking.enableB43Firmware = true;

  programs.ssh.startAgent = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    audacity
    blender
    gnome3.adwaita-icon-theme
    calibre
    chromium
    cudatoolkit
    dmenu
    duplicity
    direnv
    emacs
    evince
    firefox
    font-awesome
    gcc
    gimp
    git
    gparted
    i3-gaps
    i3lock
    i3status
    killall
    lightdm
    nerdfonts
    nitrogen
    pasystray
    pamix
    pavucontrol
    pciutils
    polybarFull
    rofi
    niv
    sakura
    source-code-pro ## Font
    xfce.thunar
    xdotool
    xorg.xev
    thunderbird
    vim
    wally-cli
    weechat
    wget
    zoom-us
  ];

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      source-code-pro
    ];
  };


  users.users.ashton = {
    isNormalUser = true;
    home = "/home/ashton";
    extraGroups = [ "wheel" "networkmanager" ];
    openssh.authorizedKeys.keys = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC9cjqiHUAbkHv/hv3ncZwed9eojhZXTlY9X0ApGkamQgznLpg5IzIPa4dFwVRg9380dKDGoZqESc5tXkOklIJSO6UXJu8VV2SrbnQyZscs75bMtCjrQZFBo5zq48Ch5FafivVOoDGv+3AbpaL25ZNLmqLeCsX7NkrpSoh1DCtFcCEJTV/oVo5gLj77FcBip7O6TZymZP0DueS2x3akGR6qxadc7R+EZ+DmZb1WKd9z9FYRTR79b+b65FFs14ni4pH/OVpDvRxnEZUx6yJzHClKHLrw7Ehf2yJDZnXFAVnXujqHatWDHTd6IvniAanPLwNlUlYdwMK38yzQ7f0a+eP/ ashtonkemerling@Ashtons-Mac-mini.local"];
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  nixpkgs.config.pulseaudio = true;


  nixpkgs.config.allowUnfree = true;
  # Enable U2F
  hardware.u2f.enable = true;

  systemd.services.nvidia-control-devices = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig.ExecStart = "${pkgs.linuxPackages.nvidia_x11.bin}/bin/nvidia-smi";
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?
}
