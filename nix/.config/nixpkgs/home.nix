{ config, pkgs, ... }:

{
  home.username = "aayu";
  home.homeDirectory = "/home/aayu";

  home.stateVersion = "22.11";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # Go!
    curlie
    f2
    gdu

    # Rust CLI tools
    bat
    du-dust
    fd
    lsd
    ripgrep
    vimv-rs

    # dependencies
    playerctl      # polybar spotify module
    pulseaudio-ctl # polybar

    # cli
    bunnyfetch
    didyoumean
    ffsend
    fzf
    fzy
    gcal
    imgurbash2
    jdupes
    maim
    nodePackages_latest.insect
    pdd
    pfetch
    slop
    translate-shell
    ueberzug

    # development
    android-tools
    fx
    gron
    lynx
    mdcat
    newsboat
    pup
    tesseract5
    tmux
    urlscan
    zbar

    # files
    lf
    sox
    tree
    zathura

    # i3wm
    dunst
    font-awesome
    j4-dmenu-desktop
    polybarFull
    xorg.xbacklight
    xidlehook

    # media
    cmus
    exiftool
    gifsicle
    mat2
    nsxiv
    peek
    setroot

    # misc
    cava
    cmatrix
    cowsay
    figlet
    hollywood
    pipes-rs
    toilet

    # overview
    btop
    glances
    lazydocker
    lazygit
    yad

    # shell related
    atuin
    babelfish
    mcfly
    zoxide
  ];
}
