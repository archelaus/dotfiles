{ config, pkgs, ... }:

{
  home.username = "aayu";
  home.homeDirectory = "/home/aayu";

  home.stateVersion = "22.11";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # Go!
    gdu

    # Rust CLI tools
    bat
    du-dust
    fd
    ripgrep

    # dependencies
    rlwrap # cht.sh

    # cli
    atuin
    cht-sh
    fzf
    jdupes
    mcfly
    nodePackages_latest.insect
    maim
    ytfzf
    zoxide

    # development
    fx
    glow
    gron
    pup

    # files
    feh
    lf
    lsd
    zathura

    # i3wm
    autotiling
    dunst
    font-awesome
    haskellPackages.greenclip
    j4-dmenu-desktop
    picom-next
    playerctl
    pulseaudio-ctl
    xorg.xbacklight
    xidlehook

    # media
    exiftool
    mat2

    # overview
    bottom
    btop
    lazydocker
    lazygit
    procs

    # shell related
    babelfish
  ];

  programs.bat = {
    enable = true;
    config = {
      theme = "ansi";
    };
  };
}
