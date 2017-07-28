export OS="$(~/bin/which-os)"
export ZSH="${HOME}/.oh-my-zsh"

# Location
export docs=~/Documents
export p=~/Projects
export dbox=~/Dropbox
export life=$dbox/life
export org=$dbox/org
export notes=$life/notes
export config=$p/configuration

# environment fun
export EDITOR=/usr/local/bin/nvim
export CLICOLOR=1

# gnu global tags
export MAKEOBJDIRPREFIX=$HOME/wa/globaltags

if [ "${OS}" = 'macos' ]; then
  # Homebrew
  HOMEBREW_PREFIX="$(brew --prefix)"
  PATH="${HOMEBREW_PREFIX}/opt/coreutils/libexec/gnubin:${PATH}"
  PATH="${HOMEBREW_PREFIX}/sbin:${PATH}"
  PATH="${PATH}:/Applications/TeX/TeXShop.app/Contents/Resources/TeXShop/bin"
  PATH="${PATH}:/opt/local/bin:/opt/local/sbin"
  MANPATH="${HOMBREW_PREFIX}/opt/coreutils/libexec/gnuman:${MANPATH}"

  FDK_EXE="${HOME}/bin/FDK/Tools/osx"
  SSH_ASKPASS="$HOMEBREW_PREFIX/bin/ssh-askpass"

fi

export FDK_EXE

export NVM_DIR="${HOME}/.nvm"
[ -s "${NVM_DIR}/nvm.sh" ] && . "${NVM_DIR}/nvm.sh" --no-use 

export MANPATH

# path
PATH="${PATH}:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# PATH=$PATH:/Library/TeX/texbin
PATH="${PATH}:${HOME}/bin"
PATH="${PATH}:${p}/go/bin"
PATH="${PATH}:${FDX_EXE}"
PATH="${PATH}:${NVM_BIN}"
export PATH

# Local Config
if [ -f "${PZSH}/environment.local.sh" ]; then
  source "$PZSH/environment.local.sh"
fi

export PATH=$(echo $PATH | tr ':' '\n' | sort | uniq | tr '\n' ':')
