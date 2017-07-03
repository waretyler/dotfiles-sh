#!/bin/bash 

download () {
  cd ~/Downloads
  curl -O "$@"
  cd -
}

pre_search () {
  if [ -z "$(echo $1 | sed 's/ //g')" ]; then
    read "search?Search: " 
    echo $search 
  else
    echo $@
  fi
}

search () {
  ARGS="$(pre_search $@)"
  open "https://duckduckgo.com?q=${ARGS}"
}

select_github_repositories () {
  ARGS=$(pre_search $@)
  curl -s -X GET "https://api.github.com/search/repositories?q=${ARGS}" | jq -r ".items[].full_name" | fzf -m
}

firstSub () {
  if ! test -z "$1"; then
    local dir=$(pwd | grep -F "$1" | sed "s|$1\([^/]*\).*|\1|")
    echo $dir
  else
    echo $1
  fi
}

eCd() {
  # $1 is path 
  # $2 is name 
  # $3 is file extension 
  # $4 vimCmd
  # $5 vimOptions
  if ! test -z "$2"; then
    local vimCmd="cd $1"
    if ! test -z "$4"; then
      local vimCmd="$vimCmd | $4"
    fi

    eval "nvim $1/$2$3 -c \"$vimCmd\" $5"
  fi
}

dirList() {
  reply=( $(cd $1 && ls -1 *$2 | sed "s/$2\$//") )
}

dirComp() {
  eval "function {
    $1List(){ 
      dirList $2 $3 
    }
    compctl -K \"$1List\" \"$1\" 
  }"
}

quick() {
  if [ "$2" != 'e' ]; then
    body="file_path=\"$3/\$1$4\"; if [ ! -f \"\${file_path}\" ]; then; touch \"\${file_path}\"; fi; $2 \"\${file_path}\""
  else
  # $1 function name, $2 root, $3 associated extension
    body="eCd $3 "'"$1"'" \"$4\" \"$5\" \"$6\""
  fi

  eval "$1(){ ${body} }"
  dirComp $1 $3 $4
}

termTitle () {
  # information about what is in the terminal tab 
  # Expand to some notion of process running?
  local title=$(firstSub $HOME/) 

  if test -z "$title"; then
    local title=$(firstSub /Users/) 
  fi

  if test -z "$title"; then
    local title=$(firstSub /) 

  fi

  echo -ne "\033]0;${title}\007"
}

precmd () { termTitle }

man () {
  /usr/bin/man $@ || (help $@ 2> /dev/null && help $@ | less)
}

journal() {
  nvim "$life/journal.md" -c "normal Godts YpVr-o" +star
}

# make functions that allow quick editing and completion of files
quick kl 'e' "$life/klist" '.md'
quick n 'open' $life/notes '.org'
quick esh 'e' $PZSH '.sh'
quick ebin 'e' ~/bin ''
quick lesson 'e' "$life/lesson" ".md" "normal Godts YpVr-vipgqo" "+star"

svnWrapper() {
  if [[ "$1" == "diff" ]]; then
    colorsvn $@ | colordiff
  elif [[ "$1" == "up" ]] || [[ "$1" == "update" ]]; then
    colorsvn $@ 
    maketags
  else
    colorsvn $@ 
  fi
}

switchVimConfig() {
    local NVIM_CONFIG_DIR=~/.config/nvim
    rm $NVIM_CONFIG_DIR
    ln -s $1 $NVIM_CONFIG_DIR
}

switchToSpaceVim() { switchVimConfig ~/.SpaceVim; }
switchFromSpaceVim() { switchVimConfig ~/.config/nvim_back; }

switchEmacsConfig() {
    local EMACS_CONFIG_DIR=~/.emacs.d
    rm $EMACS_CONFIG_DIR 

    ln -s $1 $EMACS_CONFIG_DIR 
}

switchToSpacemacs() { switchEmacsConfig ~/.spacemacs.d }
switchFromSpacemacs() { switchEmacsConfig ~/.emacs_back.d }
