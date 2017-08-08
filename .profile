if hash greadlink 2>/dev/null; then
    READLINK=greadlink
else
    READLINK=readlink
fi

export PZSH="$(dirname "$( $READLINK -f ~/.profile)")"
source $PZSH/environment.sh

hash nvm 2>/dev/null && nvm use --silent default
