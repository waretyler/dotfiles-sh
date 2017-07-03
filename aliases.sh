alias -g e="nvim"
alias -g ef='nvim `fzf -m`'
alias -g .so=". ~/.zshrc"

# LaTex
alias watchtex="latexmk -gg -bibtex-cond -pdf -pvc"
alias cleantex="rm *.{aux,fdb_latexmk,fls,log,pdf}"
alias lt="tree -LC 2"
alias less="less -r"

alias patch.paste="pbpaste | patch -p0"
alias git.root="cd \$(git rev-parse --show-toplevel)"
alias git.clean="(git ls-files -md | xargs git reset HEAD) && (git ls-files -md | xargs git checkout --) && (git ls-files -o --exclude-standard | xargs rm -rf)"
alias s?="search"

# macos specfic
if [ "$OS" = "macos" ]; then
  alias osReference="grep '^ *kVK' /System/Library/Frameworks/Carbon.framework/Versions/A/Frameworks/HIToolbox.framework/Versions/A/Headers/Events.h|tr -d ,|while read x y z;do printf '%d %s %s\n' $z $z ${x#kVK_};done|sort -n"
fi

# Local configuration
if [ -f $PZSH/aliases.local.sh ]; then
  source $PZSH/aliases.local.sh
fi
