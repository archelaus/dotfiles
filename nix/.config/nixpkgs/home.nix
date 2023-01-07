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
    rlwrap         # cht.sh

    # cli
    bunnyfetch
    cht-sh
    didyoumean
    fzf
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
    fx
    gron
    lynx
    mdcat
    pup
    tesseract5
    tmux
    zbar

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
    cmus
    exiftool
    mat2
    nsxiv
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
    zoxide
  ];
}
