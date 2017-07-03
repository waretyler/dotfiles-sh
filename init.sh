source "$HOME/.profile"

ZSH_THEME="avit"

# Completion
fpath=("${HOME}/.zsh/completion" $fpath) 
fpath=($fpath "${PZSH}/completions")

autoload -U compinit
compinit

plugins=(svn npm)


source_files=( \
  "$ZSH/oh-my-zsh.sh" \
  "$PZSH/aliases.sh" \
  "$PZSH/functions.sh" \
  "$HOME/.source/composure.sh" \
)

for source_file in ${source_files[*]}; do
  if [ -f "${source_file}" ]; then
    source "${source_file}"
  else
    echo "Warning: There was an issue sourcing '${source_file}'"
  fi
done


#set vi mode
# set -o vi

# Bind keys
bindkey "\C-f" history-incremental-search-forward 
bindkey "\C-r" history-incremental-search-backward

bindkey "\C-n" down-line-or-history 
bindkey "\C-p" up-line-or-history 

#for bash
#bind '"\C-f": forward-search-history'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /Users/tware/.nvm/versions/node/v7.10.0/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/tware/.nvm/versions/node/v7.10.0/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /Users/tware/.nvm/versions/node/v7.10.0/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/tware/.nvm/versions/node/v7.10.0/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh