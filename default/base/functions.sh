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

find_dir() {
  local exclude=''
  if [ ! -z "$2" ]; then
    exclude="-E '*$2*'"
  fi

  fd -HIL "$1" -t d "$exclude" 
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

g_fdiff () {
  if [ -z "$1" ]; then
    exit; 
  fi
  git --no-pager diff --name-status $1 | fzf -m --preview "cd $(git rev-parse --show-toplevel) && git --no-pager  diff --color=always $1 -- {-1}"
}

csvcutf() {
  csvcut -c "$(csvcut -n $1 | fzf -m | egrep -oh '^\s*[0-9]*' | sed -e 's/\s//g' | head -c -1 | tr '\n' ',')" $1 
}



calc () {
  if [ -z "$1" ]; then
    julia 
  else
    julia -E "$(echo $@)"
  fi
}



fzf_dir() {
  local dir="${1:-.}"
  cd $dir && fd -HIL -d "${2:-7}" -t d | filter.dir --line-buffered | filter.empty --line-buffered | fzf
}

cd_fzf_to_dir() {
  if [ ! -z "$1" ]; then
    local dir="$1"
  elif [ ! -z "$(find_project_root)" ]; then
    local dir="$(find_project_root)"
  else
    local dir="."
  fi

  cd "$dir/$(fzf_dir "$dir")"
}

find_project_dirs() {
  local dir="${1:-.}"
  (cd $dir && fd -HIL -t d "$(get_project_pattern)" | sed 's/\/[^/]*$//' | fzf)
}

find_project_dirs_and_cd() {
  if [ ! -z "$1" ]; then
    local dir="$1"
  else
    local dir="."
  fi

  cd "$dir/$(find_project_dirs "$dir")"
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
    | while read -r dir; do
      local dir_sans_prefix="$(echo $dir | sed "s/^$dir_prefix//")"
      mv "$dir" "./${dest_dir}/${dir_sans_prefix}"
    done
}

get_project_pattern() {
  echo "\.git|\.svn|\.idea"
}

find_parent_dir_with() {
  if [ -z "$1" ]; then
    echo "Must pass a pattern" 
    return
  fi

  local dir="";

  while [ "$(pwd)" != "/" ]; do
    if [ ! -z "$(ls -a | egrep "/(${1})$")" ]; then
      pwd
      break
    else
      cd ..
    fi
  done
}

find_project_root() {
  find_parent_dir_with "$(get_project_pattern)"
}
