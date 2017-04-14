# source ~/.bash_profile
# resides.  Note that this resolves symlinks (HT Gerrit Imsieke). First check
# if greadlink exists (Mac OS X) and if so, use that.

if hash greadlink 2>/dev/null; then
    READLINK=greadlink
else
    READLINK=readlink
fi

export PZSH="$(dirname "$( $READLINK -f ~/.zshrc )")"
source $PZSH/environment.sh --no-use

ZSH_THEME="avit"
fpath=(~/.zsh/completion $fpath) 
fpath=($fpath $PZSH/completions)

zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name '' 

autoload -U compinit

plugins=(svn npm)

source $ZSH/oh-my-zsh.sh --no-use
source $PZSH/aliases.sh --no-use
source $PZSH/functions.sh --no-use

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" --no-use 
