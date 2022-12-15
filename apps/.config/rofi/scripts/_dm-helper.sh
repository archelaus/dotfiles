#!/usr/bin/env bash

if [[ $BASH_SOURCE == $0 ]]; then
  echo "This is a helper-script. It does not do anything on its own."
  exit 1
fi

###########################
#   Configuration stuff   #
###########################

get_local_config() {
  # Do some subshell magic finding out where the script we are running 
  # is located and checking if ../config is a dir relative to the script
  echo "$(
    cd "$(dirname "$(readlink "$BASH_SOURCE" || echo ".")")./"
    if [[ -d "${PWD}/config" ]]; then
      echo "${PWD}/config"
    fi
  )"
}


get_config() {
  local _config_files=()
  local _local_conf
  _local_conf="$(get_local_config)"

  # add User config path
  _config_files+=( "${HOME}/.config/dmscripts/config" )

  # Add global installed config path
  # _config_files+=( "/etc/dmscripts/config" )

  for conf in "${_config_files[@]}"; do
    if [[ -f ${conf} ]]; then
      echo "${conf}"
      return
    fi
  done
}

######################
#   Error handling   #
######################

# Simple warn function
warn () {
  printf 'Warn: %s\n' "$1"
}

# Simple error function
err () { 
  printf 'Error: %s\n' "$1"
  exit 1
}

############################
#   Dislay server checks   #
############################

# Boiler code for if you want to do something with display servers

#function() {
#  case "$XDG_SESSION_TYPE" in
#    'x11') something with x;;
#    'wayland') something with wayland;;
#    *) err "Unknown display server";;
#  esac
#}

# Function to copy to clipboard with different tools depending on the display server

cp2cb() {
  case "$XDG_SESSION_TYPE" in
    'x11') xclip -r -selection clipboard;;
    'wayland') wl-copy -n;; 
    *) err "Unknown display server";; 
  esac
}

grep-desktop() {
  case "$XDG_SESSION_TYPE" in
    'x11') grep "Name=" /usr/share/xsessions/*.desktop | cut -d'=' -f2;;
    'wayland') grep "Name=" /usr/share/wayland-sessions/*.desktop | cut -d'=' -f2 || grep "Name=" /usr/share/xsessions/*.desktop | grep -i "wayland" | cut -d'=' -f2 | cut -d' ' -f1;; 
    *) err "Unknown display server";;
  esac
}

###############
#   Parsing   #
###############

xmlgetnext () {
  local IFS='>'
  # we need to mangle backslashes for this to work
  # shellcheck disable=SC2162
  read -d '<' TAG VALUE
}

parse_rss() {
  echo "$1" | while xmlgetnext ; do
    case $TAG in
        'entry')
          title=''
          link=''
          published=''
          ;;
        'media:title')
          title="$VALUE"
          ;;
        'yt:videoId')
          link="$VALUE"
          ;;
        'published')
          published="$(date --date="${VALUE}" "+%Y-%m-%d %H:%M")"
            ;;
        '/entry')
          echo " ${published} | ${link} | ${title}"
          ;;
        esac
  done
}
