{ config, pkgs, ... }:

{
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "dvorak";
    xkb.options = "caps:swapescape";
    autoRepeatDelay = 200; # 200 ms
    autoRepeatInterval = 10; # 100 Hz
  };
  console.useXkbConfig = true; # dvorak and swapescape

  services.xserver.desktopManager.gnome.sessionPath = [
    pkgs.gnomeExtensions.just-perfection # TODO does not seem to work
  ];
  services.xserver.desktopManager.gnome.extraGSettingsOverrides = ''
    [org.gnome.desktop.peripherals.keyboard]
    delay=200
    repeat-interval=10
    [org.gnome.desktop.peripherals.mouse]
    speed=1
    accel-profile='flat'
    [org.gnome.desktop.session]
    idle-delay=0
    [org.gnome.desktop.interface]
    color-scheme='prefer-dark'
    [org.gnome.desktop.wm.keybindings]
    switch-applications=[]
    switch-applications-backward=[]
    switch-windows=['<Super>Tab', '<Alt>Tab']
    switch-windows-backward=['<Shift><Super>Tab', '<Shift><Alt>Tab']
    show-desktop=['<Super>d']
    [org.gnome.shell]
    disable-user-extensions=false
    enabled-extensions=['just-perfection-desktop@just-perfection', 'launch-new-instance@gnome-shell-extensions.gcampax.github.com']
    [org.gnome.settings-daemon.plugins.power]
    idle-dim=false
    power-saver-profile-on-low-battery=false
    sleep-inactive-ac-type='nothing'
    sleep-inactive-ac-timeout=0
    sleep-inactive-battery-type='nothing'
    sleep-inactive-battery-timeout=0
    [org.gnome.nautilus.preferences]
    search-filter-time-type='last_modified'
    default-sort-order='mtime'
    default-sort-in-reverse-order='true'
    [org.gnome.desktop.peripherals.touchpad]
    disable-while-typing=false
    [org/gnome/settings-daemon/plugins/media-keys]
    custom-keybindings=['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']
    [org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0]
    binding='<Super>t'
    command='kitty'
    name='Terminal'
  '';

  services.syncthing = {
    enable = true;
    user = "blackbot7";
    dataDir = "/home/blackbot7/";
    configDir = "/home/blackbot7/.config/syncthing";
  };
  programs.fish.enable = true;
  programs.fish.promptInit = ''
    any-nix-shell fish --info-right | source
  ''; # make nix-shell use fish
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
    enableSSHSupport = true;
  };
  users.users.blackbot7 = {
    isNormalUser = true;
    description = "Emilien Breton";
    extraGroups = [ "networkmanager" "wheel" "dialout" ];
    shell = pkgs.fish;
    packages = with pkgs; [
      # languages
      python3
      nodejs
      rustup
      clang
      gcc
      ghc
      # terminal
      config.boot.kernelPackages.perf
      trash-cli
      diskonaut
      neofetch
      ripgrep
      radare2
      gnumake
      screen
      pandoc
      neovim
      zoxide
      gnupg
      fish
      acpi
      htop
      eza # exa fork
      vim
      pv
      # graphical
      logisim-evolution
      protonvpn-gui
      gnome.totem
      obs-studio
      syncthing
      obsidian
      gcolor3
      kitty
      brave
      cura
      # libraries
      gnomeExtensions.just-perfection
      llvmPackages_18.clang-tools # clangd for Neovim
      python311Packages.pip
      any-nix-shell # for nix-shell
      xclip # for Neovim
      typst # for Pandoc
    ];
  };

  fonts.packages = with pkgs; [
    nerdfonts # Fira Code
  ];
}
