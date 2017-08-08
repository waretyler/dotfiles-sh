alias -g .so=". ~/.zshrc"
alias g="git"

alias f="fzf --query"

# LaTex
alias watchtex="latexmk -gg -bibtex-cond -pdf -pvc"
alias cleantex="rm *.{aux,fdb_latexmk,fls,log,pdf}"
alias lt="tree -LC 2"
alias less="less -r"

alias patch.paste="pbpaste | patch -p0"

alias lf="ls_fzf"
alias ls.d="(find . -type d | sed 's/\/$//')"
alias ls.idea='(ls_dir_match ".idea" "node_modules")'
alias ls.git='(ls_dir_match ".git" "node_modules")'

alias lp='(cd $p && (ls.git | cut -b 3-))'
alias cdp='project_dir=$(lp | fzf) && cd "$p/$project_dir"' 

alias -g e="nvim"
alias -g ef='edit_files=$(fzf -m) && (echo $edit_files | xargs nvim)'
alias -g e.p='cd.p && ef'

alias rmf="(fzf -m || exit 0) | rm -rf"

alias g.root="cd \$(git rev-parse --show-toplevel)"
alias g.clean="(git ls-files -md | xargs git reset HEAD) && (git ls-files -md | xargs git checkout --) && (git ls-files -o --exclude-standard | xargs rm -rf)"
alias g.ppull='(cd.p && git pull)'

alias gh.select_repo='github_repo=$(select_github_repositories)'
alias gh.clone='(gh.select_repo && cd $p && git clone "https://github.com/${github_repo}")'
alias gh.view='(gh.select_repo && xdg-open "https://github.com/${github_repo}")'

alias gco='branch_to_checkout=$(git branch | fzf | cut -c 3-) && git checkout $branch_to_checkout'

#alias s?="search"
alias www='($FIREFOX_PROFILE && sqlite3 "$FIREFOX_PROFILE/places.sqlite" "select host from moz_hosts order by frecency desc;" | fzf | sed "s;^;https://;" | xargs xdg-open)'

# macos specfic
if [ "$OS" = "macos" ]; then
  alias osReference="grep '^ *kVK' /System/Library/Frameworks/Carbon.framework/Versions/A/Frameworks/HIToolbox.framework/Versions/A/Headers/Events.h|tr -d ,|while read x y z;do printf '%d %s %s\n' $z $z ${x#kVK_};done|sort -n"
  alias os.o='application=$(ls -1 /Applications | sed "s/.app//" | fzf) && open -a ${application}.app'
fi

# Local configuration
if [ -f $PZSH/aliases.local.sh ]; then
  source $PZSH/aliases.local.sh
fi

if [[ "$(echo $SHELL | grep -oh '[^/]*$')" = "zsh" ]]; then
  alias bindkey.ls="bindkey | fzf > /dev/null"
fi
