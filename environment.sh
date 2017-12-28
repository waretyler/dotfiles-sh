export OS="$(uname | tr "[A-Z]" "[a-z]")"

# Location
export docs=~/Documents
export p=~/Projects
export dbox=~/Nextcloud
export life=$dbox/life
export org=$dbox/org
export notes=$life/notes
export cfg=$HOME/.config/personal
export scripts=$cfg/scripts
export s=$scripts

# environment fun
export CLICOLOR=1

# gnu global tags
export MAKEOBJDIRPREFIX=$HOME/wa/globaltags

PATH=""
EDITOR=/usr/bin/nvim
PATH="$HOME/miniconda3/bin:$PATH"

export EDITOR
export FDK_EXE


export NVM_DIR="${HOME}/.nvm"
# [ -s "${NVM_DIR}/nvm.sh" ] && . "${NVM_DIR}/nvm.sh" 
 
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
# PATH="$PATH:$HOME/.rvm/bin"

# path
PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:${PATH}"

# PATH=$PATH:/Library/TeX/texbin
PATH="${PATH}:${HOME}/bin"
PATH="${PATH}:${scripts}/utils"
PATH="${PATH}:${HOME}/go/bin"
# PATH="${PATH}:${FDX_EXE}"
export MANPATH

# Local Config
if [ -f "${PZSH}/environment.local.sh" ]; then
  source "$PZSH/environment.local.sh"
fi

if [[ -d "$HOME/.cargo" ]]; then
  PATH="${PATH}:${HOME}/.cargo/bin" 
  # source "${HOME}/.cargo/env" 
fi

# make sure nvm get's the last say on node
PATH="${NVM_BIN}:${PATH}"
export PATH

# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export FZF_DEFAULT_COMMAND='(ag --hidden --ignore node_modules --ignore .git --ignore .idea --ignore .DS_Store -g "") 2> /dev/null'
