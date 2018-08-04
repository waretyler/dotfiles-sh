export cfg="${HOME}/.config/personal"
export cfg_zsh="${cfg}/zsh"

source $cfg/zsh/utils.sh

export SHELL_NAME="$(echo $SHELL | grep -o '[^/]*$')"
export docs=~/Documents
export p=~/Projects
export dbox=~/Nextcloud
export org=$HOME/org
export scripts=$cfg/scripts
export s=$scripts

export OS="$(uname | tr "[A-Z]" "[a-z]")"

export CLICOLOR=1

if [ "$(which nvim)" ]; then
  export EDITOR=nvim
  export MANPAGER="nvim -c 'set ft=man' -"
fi

PATH=""
add_path "/usr/local/bin"
add_path "/usr/bin"
add_path "/bin"
add_path "/usr/sbin"
add_path "/sbin"
add_path "${HOME}/miniconda3/bin"
add_path "${HOME}/bin"
add_path "${scripts}/utils"
add_path "${HOME}/go/bin"
add_path "${HOME}/node_tools/node_modules/.bin" 
add_path "${HOME}/.cargo/bin" 

export GOBIN="${HOME}/go/bin"
add_path "${GOBIN}"

source_file "${cfg_zsh}/environment.local.sh"

export PATH
