add_path() {
  if [ -d "$1" ]; then
    [ ! -z "$PATH" ] && PATH="${PATH}:"
    PATH="${PATH}${1}"
  fi
}

source_file() {
  if [ -f "$1" ]; then
    source "$1"
  fi
}

source_file "$cfg_sh/$SHELL_NAME/utils.sh"
