export OS="$(uname | tr "[A-Z]" "[a-z]")"
[ "$OS" = 'darwin' ] && export HOMEBREW_PREFIX="$(brew --prefix)"
export ZSH="${HOME}/.oh-my-zsh"


# Location
export docs=~/Documents
export p=~/Projects
export dbox=~/Dropbox
export life=$dbox/life
export org=$dbox/org
export notes=$life/notes
export config=$HOME/.config/personal
export scripts=$config/scripts
export s=$scripts

# environment fun
export CLICOLOR=1

# gnu global tags
export MAKEOBJDIRPREFIX=$HOME/wa/globaltags

PATH=""

if [ "${OS}" = 'darwin' ]; then
  # Homebrew
  PATH="${HOMEBREW_PREFIX}/opt/coreutils/libexec/gnubin:${PATH}"
  PATH="${HOMEBREW_PREFIX}/opt/texinfo/bin:${PATH}"
  PATH="${HOMEBREW_PREFIX}/sbin:${PATH}"
  PATH="${HOMEBREW_PREFIX}/bin:${PATH}"
  PATH="${PATH}:/Applications/TeX/TeXShop.app/Contents/Resources/TeXShop/bin"
  PATH="${PATH}:/opt/local/bin:/opt/local/sbin"
  PATH="${PATH}:${HOME}/miniconda3/bin"
  MANPATH="${HOMBREW_PREFIX}/opt/coreutils/libexec/gnuman:${MANPATH}"

  FDK_EXE="${HOME}/bin/FDK/Tools/osx"
  SSH_ASKPASS="$HOMEBREW_PREFIX/bin/ssh-askpass"
  EDITOR=/usr/local/bin/nvim

  [ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
elif [ "${OS}" = 'linux' ]; then
  EDITOR=/usr/bin/nvim
  PATH="$HOME/miniconda3/bin:$PATH"
fi

export EDITOR
export FDK_EXE


export NVM_DIR="${HOME}/.nvm"
[ -s "${NVM_DIR}/nvm.sh" ] && . "${NVM_DIR}/nvm.sh" 

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
PATH="$PATH:$HOME/.rvm/bin"

# path
PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:${PATH}"

# PATH=$PATH:/Library/TeX/texbin
PATH="${PATH}:${HOME}/bin"
PATH="${PATH}:${scripts}/utils"
PATH="${PATH}:${p}/go/bin"
PATH="${PATH}:${FDX_EXE}"
export MANPATH

# Local Config
if [ -f "${PZSH}/environment.local.sh" ]; then
  source "$PZSH/environment.local.sh"
fi

# make sure nvm get's the last say on node
PATH="${NVM_BIN}:${PATH}"
export PATH

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export FZF_DEFAULT_COMMAND='(ag --hidden --ignore node_modules --ignore .git --ignore .idea --ignore .DS_Store -g "") 2> /dev/null'
