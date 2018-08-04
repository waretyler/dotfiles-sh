PROFILE=$(HOME)/.profile
ZSHRC=$(HOME)/.zshrc

install: link_profile link_zsh

link_profile: 
	[ -e "$(PROFILE)" -o -L "$(PROFILE)" ] && rm $(PROFILE); \
	ln -s "$$(pwd)/environment.sh" $(PROFILE)

link_zsh:
	[ -e "$(ZSHRC)" -o -L "$(ZSHRC)" ] && rm $(ZSHRC); \
	ln init.sh $(ZSHRC)
