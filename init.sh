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

[ ! -f ~/.fzf.zsh ] \
  && git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf \
  && ~/.fzf/install
source ~/.fzf.zsh

[ ! -f ~/.antigen.zsh ] && curl -L git.io/antigen > ~/.antigen.zsh
source ~/.antigen.zsh
antigen bundle cusxio/delta-prompt 
antigen bundle zsh-users/zsh-syntax-highlighting 
antigen apply

if [ -d "${HOME}/perl5" ]; then
  PATH="${HOME}/perl5/bin${PATH:+:${PATH}}"; export PATH;
  PERL5LIB="${HOME}/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
  PERL_LOCAL_LIB_ROOT="${HOME}/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
  PERL_MB_OPT="--install_base \"${HOME}/perl5\""; export PERL_MB_OPT;
  PERL_MM_OPT="INSTALL_BASE=${HOME}/perl5"; export PERL_MM_OPT;
fi

if [ -d "${HOME}/.rbenv" ]; then
  export PATH="${HOME}/.rbenv/bin:${PATH}"
  eval "$(rbenv init -)" 
fi

[ -d "${HOME}/.rbenv/plugins/ruby-build" ] && export PATH="${HOME}/.rbenv/plugins/ruby-builder/bin:${PATH}"


HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt APPEND_HISTORY # Don't erase history
setopt EXTENDED_HISTORY # Add additional data to history like timestamp
setopt INC_APPEND_HISTORY # Add immediately
setopt HIST_SAVE_NO_DUPS # Don't save any duplicates
setopt NO_HIST_BEEP # Don't beep
setopt SHARE_HISTORY # Share history between session/terminals
