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

get_script_dir() {
  if [ "$OS" = "darwin" ]; then
    echo "$(dirname "$(stat -f "$1")")" 
  else
    echo "$(dirname "$(readlink -f "$1")")"
  fi
}
