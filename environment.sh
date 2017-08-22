export OS="$(uname | tr "[A-Z]" "[a-z]")"
export ZSH="${HOME}/.oh-my-zsh"

# Location
export docs=~/Documents
export p=~/Projects
export dbox=~/Dropbox
export life=$dbox/life
export org=$dbox/org
export notes=$life/notes
export config=$HOME/.config/personal
export scripts=$HOME/scripts

# environment fun
export CLICOLOR=1

# gnu global tags
export MAKEOBJDIRPREFIX=$HOME/wa/globaltags

if [ "${OS}" = 'darwin' ]; then
  # Homebrew
  HOMEBREW_PREFIX="$(brew --prefix)"
  PATH="${HOMEBREW_PREFIX}/opt/coreutils/libexec/gnubin:${PATH}"
  PATH="${HOMEBREW_PREFIX}/sbin:${PATH}"
  PATH="${PATH}:/Applications/TeX/TeXShop.app/Contents/Resources/TeXShop/bin"
  PATH="${PATH}:/opt/local/bin:/opt/local/sbin"
  MANPATH="${HOMBREW_PREFIX}/opt/coreutils/libexec/gnuman:${MANPATH}"

  FDK_EXE="${HOME}/bin/FDK/Tools/osx"
  SSH_ASKPASS="$HOMEBREW_PREFIX/bin/ssh-askpass"
  EDITOR=/usr/local/bin/nvim

  [ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
elif [ "${OS}" = 'linux' ]; then
  EDITOR=/usr/bin/nvim
fi

export EDITOR
export FDK_EXE

export NVM_DIR="${HOME}/.nvm"
[ -s "${NVM_DIR}/nvm.sh" ] && . "${NVM_DIR}/nvm.sh" 



# path
PATH="${PATH}:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# PATH=$PATH:/Library/TeX/texbin
PATH="${PATH}:${HOME}/bin"
PATH="${PATH}:${p}/go/bin"
PATH="${PATH}:${FDX_EXE}"
PATH="${PATH}:${NVM_BIN}"
export MANPATH

# Local Config
if [ -f "${PZSH}/environment.local.sh" ]; then
  source "$PZSH/environment.local.sh"
fi

export PATH=$(echo $PATH | tr ':' '\n' | sort | uniq | tr '\n' ':')

export FZF_DEFAULT_COMMAND='(git ls-tree -r --name-only HEAD || ag -g "") 2> /dev/null'
