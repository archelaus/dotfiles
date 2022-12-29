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
    playerctl # polybar spotify module
    pulseaudio-ctl # polybar

    # cli
    bunnyfetch
    didyoumean
    fzf
    gcal
    jdupes
    maim
    navi
    nodePackages_latest.insect
    pdd
    pfetch
    slop
    tealdeer
    tmux
    translate-shell
    ueberzug

    # development
    fx
    gron
    mdcat
    pup

    # files
    lf
    zathura

    # i3wm
    autotiling
    dunst
    font-awesome
    j4-dmenu-desktop
    xorg.xbacklight
    xidlehook

    # media
    exiftool
    feh
    mat2
    nsxiv
    simplescreenrecorder

    # misc
    cava
    cmatrix
    cowsay
    figlet
    hollywood
    pacvim
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
    zoxide
  ];
}
