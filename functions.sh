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

commandInCurrent () {
  osascript -e "tell application \"iTerm2\" 
                  set mySession to (current session of current window)
                  tell mySession 
                    write text \"$1\"
                  end tell
                end tell"
}

commandInPane () {
  local direction="vertically"
  if (! [ -z "$2" ]) && [ $2 == "horizontal" ]; then
    local direction="horizontally"  
  fi

  osascript -e "tell application \"iTerm2\" 
                  set mySession to (current session of current window)
                  tell mySession 
                    set mySplit to (split $direction with default profile)
                    tell mySplit
                      write text \"$1\"
                      $3
                    end tell
                  end tell
                end tell"
}

commandInTab () {
  osascript -e "tell application \"iTerm2\" 
                  set myWindow to (current window)
                  tell myWindow 
                    set myTab to (create tab with default profile)
                    tell current session of myTab 
                      write text \"$1\"
                    end tell
                  end tell
                end tell"
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
wiki() {
  open "http://en.wikipedia.org/wiki/Special:Search/${@}"
}

clip() {
  cat $1 | pbcopy
}

nLink() {
  npm link @idearoom/{config,render,math,server-{config,render}}
}

newtab() {
  cliclick kd:cmd t:'t' ku:cmd
}

man () {
  /usr/bin/man $@ || (help $@ 2> /dev/null && help $@ | less)
}

vman() {
  nvim -c "SuperMan $*"

  if [ "$?" != "0" ]; then
    echo "No manual entry for $*"
  fi
}

oIssue () {
  if ! test -z "$1"; then
    open "https://sawtoothideas.unfuddle.com/a#/projects/9/tickets/by_number/$1?cycle=true"
  fi
}

journal() {
  nvim "$life/journal.md" -c "normal Godts YpVr-o" +star
}

# make functions that allow quick editing and completion of files
quickE plan $life/plans '.md'
quickE kl "$life/klist" '.md'
quickE iv $life/improvement '.md'
quickE esh $PZSH '.sh'
quickE ebin ~/bin '.sh'
quickE lesson "$life/lesson" ".md" "normal Godts YpVr-vipgqo" "+star"
