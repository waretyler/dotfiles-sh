source "$HOME/.profile"


# Completion
# fpath=("${HOME}/.zsh/completion" $fpath) 
# fpath=($fpath "${PZSH}/completions")

autoload -U compinit
compinit

source_files=( \
   "$PZSH/aliases.sh" \
   "$PZSH/functions.sh"
)

for source_file in ${source_files[*]}; do
  if [ -f "${source_file}" ]; then
    source "${source_file}"
  fi
done

HISTSIZE=10000
SAVEHIST=9000
HISTFILE=~/.zsh_history

#set emacs mode
set -o emacs 

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
# [[ -f /Users/tware/.nvm/versions/node/v7.10.0/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/tware/.nvm/versions/node/v7.10.0/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
# [[ -f /Users/tware/.nvm/versions/node/v7.10.0/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/tware/.nvm/versions/node/v7.10.0/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh
# [ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# TODO: Could start to have a link location, so install path doesn't matter
[ -f /usr/local/share/antigen/antigen.zsh ] && . /usr/local/share/antigen/antigen.zsh
[ -f /usr/share/zsh-antigen/antigen.zsh ] && . /usr/share/zsh-antigen/antigen.zsh

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
# export PATH="$PATH:$HOME/.rvm/bin"
# hash nvm 2>/dev/null && nvm use --silent default

antigen bundle cusxio/delta-prompt 
antigen bundle zsh-users/zsh-syntax-highlighting 
antigen apply
