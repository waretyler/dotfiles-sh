# source ~/.bash_profile
export PZSH=~/Projects/configuration/zsh
source $PZSH/environment.sh

ZSH_THEME="avit"
fpath=(~/.zsh/completion $fpath) 
fpath=($fpath $PZSH/completions)
autoload -U compinit
compinit

# compdef vman="man"
DISABLE_AUTO_TITLE="true"

plugins=(git)

source $ZSH/oh-my-zsh.sh
source $PZSH/aliases.sh
source $PZSH/functions.sh
# nvm use --silent default 

# http://superuser.com/questions/384860/how-can-i-make-zshell-skip-confirming-substitutions
# issue with this - keeps history completion from working eg: npm i pkg <CR>; ls; npm <Up> (ls is displayed instead of last npm cmd)
# setopt no_hist_verify
# use vim like cmds to edit eommands
#set -o vi

# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
