# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ./backup.nix
      ./xserver.nix
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only
  boot.loader.grub.useOSProber = true;
  boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];
  boot.initrd.kernelModules = [ "wl" ];

  fileSystems."/mnt/ubuntu" = {
    device = "/dev/disk/by-uuid/c6f915f1-2856-4f81-8cb1-df5d123c890a" ;
    fsType = "ext4";
  };

  networking.networkmanager.enable = true;
  networking.hostName = "nixos"; # Define your hostname.
  services.openssh.enable = true;

  location.latitude = ***REMOVED***;
  location.longitude = ***REMOVED***;
  location.provider = "manual";
  services.redshift.enable = true;


  # Set your time zone.
  time.timeZone = "America/Los_Angeles";
  services.lorri.enable = true;

  networking.enableB43Firmware = true;

  programs.ssh.startAgent = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    audacity
    gnome3.adwaita-icon-theme
    calibre
    chromium
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
    openjdk
    jre
    i3status
    killall
    libreoffice
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
    rustup
    sakura
    source-code-pro ## Font
    (pkgs.texlive.combine {
     inherit (pkgs.texlive) scheme-basic extsizes fontawesome koma-script
              ms xcolor pgf tcolorbox environ trimspaces
              etoolbox enumitem dashrule ifmtarg multirow latexmk
              changepage biblatex logreq xstring metafont
              collection-fontsrecommended lato fontaxes xkeyval parskip fp;
    })
    xfce.thunar
    xdotool
    xorg.xev
    thunderbird
    vim
    wally-cli
    weechat
    wget
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
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  nixpkgs.config.pulseaudio = true;


  # Necessary for Dropbox
  nixpkgs.config.allowUnfree = true;
  # Enable U2F
  hardware.u2f.enable = true;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?
}
