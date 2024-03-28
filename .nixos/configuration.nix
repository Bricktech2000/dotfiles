{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./user-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];

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

  services.xserver.libinput.enable = true; # touchpad support

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
    gnome.gedit # text editor
    gnome.epiphany # web browser
    gnome.geary # email reader
    gnome.evince # document viewer
    gnome.gnome-characters
    gnome.totem # video player
    gnome.tali # poker game
    gnome.iagno # go game
    gnome.hitori # sudoku game
    gnome.atomix # puzzle game
  ];

  services.openssh.enable = true;
  networking.firewall.enable = false;

  # required for flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # `direnv` and `nix-direnv` required for direnv on NixOS 23.05
  environment.systemPackages = with pkgs; [
    direnv
    nix-direnv
    man-pages-posix
    man-pages
    neofetch
    neovim
    unzip
    file
    htop
    wget
    curl
    zip
    git
    xxd
    gdb
    pv
  ];
  nix.settings = {
    keep-outputs = true;
    keep-derivations = true;
  };
  environment.pathsToLink = [
    "/share/nix-direnv"
  ];
  # required for mason.vim pre-compiled binaries
  programs.nix-ld.enable = true;

  system.stateVersion = "23.05";
}
