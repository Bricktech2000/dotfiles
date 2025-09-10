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

  services.pulseaudio.enable = false;
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
    cheese # webcam tool
    gnome-music
    gnome-terminal
    epiphany # web browser
    geary # email reader
    evince # document viewer
    gnome-characters
    totem # video player
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
    gnome-contacts
    gnome-weather
    gnome-clocks
    gnome-maps
    gnome-calculator
    simple-scan
    yelp
    gnome-system-monitor
    gnome-text-editor
    gnome-font-viewer
    baobab # disk usage analyzer
    gnome-logs
    gnome-connections
    gnome-console
    gnome-calendar
    seahorse # passwords and keys
    gnome-disk-utility
    snapshot # camera app
    file-roller # archive manager
  ];

  services.openssh.enable = true;
  networking.firewall.enable = false;
  security.sudo.wheelNeedsPassword = false;

  environment.systemPackages = with pkgs; [
    man-pages-posix
    man-pages
    unzip
    file
    wget
    curl
    zip
    git
    xxd
    gcc
    gdb
    # nvi # XXX fails to compile
    vim
  ];
  # required for mason.vim pre-compiled binaries
  programs.nix-ld.enable = true;

  system.stateVersion = "23.05";
}
