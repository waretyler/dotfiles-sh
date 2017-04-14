export ZSH=~/.oh-my-zsh

export docs=~/Documents
export proj=~/Projects
export dropbox=~/Dropbox
export life=$dropbox/life
export config=$proj/configuration

export EDITOR=/usr/local/bin/nvim
export CLICOLOR=1

PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
# PATH=$PATH:/Library/TeX/texbin
PATH=$PATH:~/bin
PATH=$PATH:$proj/go/bin
export PATH=$PATH

if [ -f $PZSH/environment.local.sh ]; then
  source $PZSH/environment.local.sh
fi
