{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./user-configuration.nix
  ];

  swapDevices = [ {
    device = "/var/lib/swapfile";
    size = 16*1024; # MB
  } ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];
  boot.kernel.sysctl."kernel.sysrq" = 1; # enable sysrq

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.nameservers = [ "1.1.1.1" "1.0.0.1" ];

  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";

  services.printing.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.libinput.enable = true; # touchpad support

  nixpkgs.config.allowUnfree = true;

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # remove Gnome cruft
  environment.gnome.excludePackages = with pkgs; [
    gnome-photos
    gnome-tour
    gnome.cheese # webcam tool
    gnome.gnome-music
    gnome.gnome-terminal
    gnome.epiphany # web browser
    gnome.geary # email reader
    gnome.evince # document viewer
    gnome.gnome-characters
    gnome.totem # video player
    gnome.tali # poker game
    gnome.iagno # go game
    gnome.hitori # sudoku game
    gnome.atomix # puzzle game
    gnome.gnome-contacts
    gnome.gnome-weather
    gnome.gnome-clocks
    gnome.gnome-maps
    gnome.gnome-calculator
    gnome.simple-scan
    gnome.yelp
    gnome.gnome-system-monitor
    gnome-text-editor
    gnome.gnome-font-viewer
    gnome.baobab # disk usage analyzer
    gnome.gnome-logs
    gnome-connections
    gnome-console
    gnome.gnome-calendar
    gnome.seahorse # passwords and keys
    gnome.gnome-disk-utility
    snapshot # camera app
    gnome.file-roller # archive manager
  ];

  services.openssh.enable = true;
  networking.firewall.enable = false;
  security.sudo.wheelNeedsPassword = false;

  environment.systemPackages = with pkgs; [
    man-pages-posix
    man-pages
    unzip
    file
    htop
    wget
    curl
    zip
    git
    xxd
    gcc
    gdb
    nvi
    vim
  ];
  # required for mason.vim pre-compiled binaries
  programs.nix-ld.enable = true;

  system.stateVersion = "23.05";
}
