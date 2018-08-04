[ ! -f ~/.fzf.zsh ] \
  && git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf \
  && ~/.fzf/install

source ~/.fzf.zsh

if [ ! -z "$(which ag)" ]; then
  export FZF_DEFAULT_COMMAND='(ag --hidden --ignore node_modules --ignore .git --ignore .idea --ignore .DS_Store -f -g "") 2> /dev/null'
fi
