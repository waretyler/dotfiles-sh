# Phabricator
easyarc_create() { 
  TMPFILE1=$(mktemp); TMPFILE2=$(mktemp); svn status | grep "^[\A|\M|\D]" | awk '{print $2}' > $TMPFILE1; vim -c ":0r $TMPFILE1" $TMPFILE2 ; if [ -s "$TMPFILE2" ];then arc diff $1 --create $(cat $TMPFILE2 | tr '\n' ' ') %1; else echo "Vim not written out. Aborting commit."; rm -rf $TMPFILE1; rm -rf $TMPFILE2;fi ;
}
easyarc_update() { 
  TMPFILE1=$(mktemp); TMPFILE2=$(mktemp); svn status | grep "^[\A|\M|\D]" | awk '{print $2}' > $TMPFILE1; vim -c ":0r $TMPFILE1" $TMPFILE2 ; if [ -s "$TMPFILE2" ];then arc diff --update $1 $2 $(cat $TMPFILE2 | tr '\n' ' '); else echo "Vim not written out. Aborting commit."; rm -rf $TMPFILE1; rm -rf $TMPFILE2;fi ;
}
download () {
  cd ~/Downloads
  curl -O "$@"
  cd -
}



#-----------------------------------------------------------------------
# helper functions
#-----------------------------------------------------------------------
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

quickE() {
  # $1 function name, $2 root, $3 associated extension
  eval "$1(){ eCd $2 "'"$1"'" \"$3\" \"$4\" \"$5\"}"
  dirComp $1 $2 $3
}
#-----------------------------------------------------------------------
# title
#-----------------------------------------------------------------------
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

#-----------------------------------------------------------------------
# project management
#-----------------------------------------------------------------------

pjRoot=~/Projects/project-list
pj() {
  if ! test -z "$1"; then
    # eval "$pjRoot/$1.sh"
    source "$pjRoot/$1.sh"
  fi
}
quickE epj $pjRoot '.sh'


pjo() {
  if ! test -z "$1"; then
    open $(cat $pjRoot/links/$1) 
  fi
}
quickE epjo $pjRoot/links ''

pje() {
  if ! test -z "$1"; then
    # using eval to handle environment vars
    eval "cd $(cat $pjRoot/edit/$1)"
    e
  fi
}
quickE epje $pjRoot/edit ''

#-----------------------------------------------------------------------
# misc
#-----------------------------------------------------------------------
man () {
  /usr/bin/man $@ || (help $@ 2> /dev/null && help $@ | less)
}

journal() {
  nvim "$life/journal.md" -c "normal Godts YpVr-o" +star
}

# make functions that allow quick editing and completion of files
quickE plan $life/plans '.md'
quickE kl "$life/klist" '.md'
quickE n $life/improvement '.md'
quickE esh $PZSH '.sh'
quickE ebin ~/bin ''
quickE lesson "$life/lesson" ".md" "normal Godts YpVr-vipgqo" "+star"

ctagUpdate() {
    ag -g '' . | xargs ctags -a
}

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
