if hash greadlink 2>/dev/null; then
    READLINK=greadlink
else
    READLINK=readlink
fi

export PZSH="$(dirname "$( $READLINK -f ~/.profile)")"
source $PZSH/environment.sh

nvm use --silent default 
