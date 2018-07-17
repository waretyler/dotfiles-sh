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

ls_fzf () {
  if [[ -z "$1" ]] && [[ "$1" = "--" ]]; then
    shift
    bash -c "ls $@"
  else
    bash -c "ls $@ | fzf > /dev/null"
  fi
}

ssh_to_tmux () {
  local extra=''
  if [[ "$3" != "" ]]; then
    local extra="send-keys '$3' Enter"
  fi

  ssh $1 -t "tmux new -s \"\$(whoami)\" \\; set -g status-bg $2 \\; $extra || tmux attach -t \"\$(whoami)\" \\; $extra "
}

ls_dir_match() {
  local exclude=''
  if [ ! -z "$2" ]; then
    exclude="-not -path '*$2*'"
  fi

  local command="find . -type d -name $1 $exclude | sed \"s/[^/]*$//\""  
  bash -c "$command"
}

search () {
  ARGS="$(pre_search $@)"
  xdg-open "https://duckduckgo.com?q=${ARGS}"
}

github_get_search() {
  for i in $(seq 2); do
    curl -s -X GET "https://api.github.com/search/repositories?page=${i}&per_page=100&q=$@" | jq -r '.items[].full_name'  
  done
}

select_github_repositories () {
  ARGS=$(pre_search $@)
  github_get_search $ARGS | fzf 
}

github_repos () {
  curl -s \
    -H "Authorization: Bearer ${GH_TOKEN}" \
    -X POST \
    -d "{ \"query\": \" \
     query { \
      search(query: \\\"$1\\\", type: REPOSITORY, first:50) { \
        repositoryCount \
        pageInfo { \
          endCursor \
          startCursor \
        } \
        edges { \
          node { \
            ... on Repository { \
              nameWithOwner \
            } \
          } \
        } \
      } \
    }  \
    \" }" \
    "${GH_BASE}/api/graphql" \
    | jq -r '.data.search.edges[].node | .nameWithOwner' \
    | sort
}

man () {
  /usr/bin/man $@ || (help $@ 2> /dev/null && help $@ | less)
}


wiki() {
  local query="${@}"
  w3m "https://en.wikipedia.org/w/index.php?search=${query}"
}

ddg() {
  local query="${@}"
  w3m "https://ddg.gg/?q=${query}"
}

jcat () {
  cat $@ | jq .
}


fzf_choose_script() {
    local script_to_run=$(ssel)
    LBUFFER="${LBUFFER}${script_to_run}"
    local ret=$?
    zle redisplay
    typeset -f zle-line-init >/dev/null && zle zle-line-init
    return $ret
}


zle     -N    fzf_choose_script
bindkey '\er' fzf_choose_script

fzf_choose_command() {
  local command_to_run=$((for dir in $path; do
  ls $dir 
  done && (alias | cut -d = -f 1)) | \
    sort | \
    fzf --preview '(man {} 2>/dev/null) || (cat $(which {}) 2>/dev/null) || echo "No clue about: {}"')
    LBUFFER="${LBUFFER}${command_to_run}"
    local ret=$?
    zle redisplay
    typeset -f zle-line-init >/dev/null && zle zle-line-init
    return $ret
}

zle     -N    fzf_choose_command
bindkey '\ee' fzf_choose_command

g_fdiff () {
  if [ -z "$1" ]; then
    exit; 
  fi
  git --no-pager diff --name-status $1 | fzf -m --preview "cd $(git rev-parse --show-toplevel) && git --no-pager  diff --color=always $1 -- {-1}"
}


csvcutf() {
  csvcut -c "$(csvcut -n $1 | fzf -m | egrep -oh '^\s*[0-9]*' | sed -e 's/\s//g' | head -c -1 | tr '\n' ',')" $1 
}


# Local Config
if [ -f "${PZSH}/functions.local.sh" ]; then
  source "$PZSH/functions.local.sh"
fi

calc () {
  if [ -z "$1" ]; then
    julia 
  else
    julia -E "$(echo $@)"
  fi
}

fzf-git-show() {
  local out shas sha q k

  if [[ -d .git ]] || git rev-parse --git-dir > /dev/null 2>&1; then
    while out=$(
        git log --graph --color=always \
            --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
        fzf --ansi --multi --no-sort --reverse --query="$q" \
            --print-query \
            --expect=ctrl-d,ctrl-l,ctrl-n \
            --toggle-sort=\`); do

      q=$(head -1 <<< "$out")
      k=$(head -2 <<< "$out" | tail -1)
      shas=$(sed '1,2d;s/^[^a-z0-9]*//;/^$/d' <<< "$out" | awk '{print $1}')

      [[ -z "$shas" ]] && continue

      case "$k" in
        ctrl-d)
          git diff --color=always $shas | less -R;;
        ctrl-l)
          git log -p --color=always ${shas}.. | less -R;;
        ctrl-n)
          git show --name-status --color=always ${shas} | less -R;;
        *)
          for sha in $shas; do
            git show --color=always $sha | less -R
          done
          ;;
      esac
    done
  else
    echo -e "Not a git repo"
  fi

  zle accept-line
}

zle     -N    fzf-git-show
bindkey '\eq' fzf-git-show


get_dir() {
  echo "${1:-.}"
}

fzf_dir() {
  local dir="$(get_dir $1)"
  cd $dir && find -L . -maxdepth ${2:-7} -type d | perl -lne 'print tr:/::, " $_"' | sort -n | cut -d' ' -f2 | cut -c 3- | filter.dir | filter.empty | fzf
}

cd_fzf_to_dir() {
  local dir="$(get_dir $1)"
  cd "$dir/$(fzf_dir "$dir" "2")"
}

explain () {
    if [ "$#" -eq 0 ]; then
        while read  -p "Command: " cmd; do
            curl -Gs "https://www.mankier.com/api/explain/?cols="$(tput cols) --data-urlencode "q=$cmd"
        done
        echo -e "\n"
    elif [ "$#" -eq 1 ]; then
        curl -Gs "https://www.mankier.com/api/explain/?cols="$(tput cols) --data-urlencode "q=$1"
    else
        echo "Usage"
        echo "explain                  interactive mode."
        echo "explain 'cmd -o | ...'   quoted command to be explainedt."
    fi
}

mv_up() {
  if [ -z "$1" ]; then
    return 
  fi

  local dest_dir="$1"
  local seperator="-"
  local dir_prefix="${dest_dir}${seperator}"

  mkdir "$dest_dir" && \
  ls | grep "$dir_prefix" \
    | while read -r dir; do;
      local dir_sans_prefix="$(echo $dir | sed "s/^$dir_prefix//")"
      mv "$dir" "./${dest_dir}/${dir_sans_prefix}"
    done
}


