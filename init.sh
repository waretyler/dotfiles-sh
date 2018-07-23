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


#set emacs mode
set -o emacs 

# Bind keys
bindkey "\C-f" history-incremental-search-forward 
bindkey "\C-r" history-incremental-search-backward

bindkey "\C-n" down-line-or-history 
bindkey "\C-p" up-line-or-history 

autoload -U edit-command-line
zle -N edit-command-line
bindkey "\C-x\C-e" edit-command-line 

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

if [ -d "/home/tware/perl5" ]; then
  PATH="/home/tware/perl5/bin${PATH:+:${PATH}}"; export PATH;
  PERL5LIB="/home/tware/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
  PERL_LOCAL_LIB_ROOT="/home/tware/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
  PERL_MB_OPT="--install_base \"/home/tware/perl5\""; export PERL_MB_OPT;
  PERL_MM_OPT="INSTALL_BASE=/home/tware/perl5"; export PERL_MM_OPT;
fi


HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt APPEND_HISTORY # Don't erase history
setopt EXTENDED_HISTORY # Add additional data to history like timestamp
setopt INC_APPEND_HISTORY # Add immediately
setopt HIST_SAVE_NO_DUPS # Don't save any duplicates
setopt NO_HIST_BEEP # Don't beep
setopt SHARE_HISTORY # Share history between session/terminals
