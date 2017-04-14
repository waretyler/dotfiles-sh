# alias vim="nvim"
alias e="nvim"

alias gpr="git pull --rebase"

alias watchtex="latexmk -gg -bibtex-cond -pdf -pvc"
alias cleantex="rm *.{aux,fdb_latexmk,fls,log,pdf}"

alias osReference="grep '^ *kVK' /System/Library/Frameworks/Carbon.framework/Versions/A/Frameworks/HIToolbox.framework/Versions/A/Headers/Events.h|tr -d ,|while read x y z;do printf '%d %s %s\n' $z $z ${x#kVK_};done|sort -n"

if [ -f $PZSH/aliases.local.sh ]; then
  source $PZSH/aliases.local.sh
fi

alias .so=". ~/.zshrc"

alias cd.pj="cd $proj"

alias ctags="ctags --sort=foldcase"

export MAKEOBJDIRPREFIX=$HOME/wa/globaltags
# alias maketags_cpp='GTAGSFORCECPP=1 $(maketags)'
alias n="iv"
