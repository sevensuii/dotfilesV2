# Makefile para manejar la configuración de los dotfiles

.DEFAULT_GOAL := help


## WM commands


## Dotfiles commands
install-symbolic-config: ## Copies repo folders to .config using symbolic links
	@echo 'Copying dotfiles' \
        && cp -srf ~/git_repos/dotfilesV2/{alacritty,fish,kitty,neofetch,picom,polybar,qtile,rofi,starship.toml} ~/.config

install-copy-config: ## Copies repo folders to .config
	@echo 'Copying dotfiles' \
        && cp -rf ~/git_repos/dotfilesV2/{alacritty,fish,kitty,neofetch,picom,polybar,qtile,rofi,starship.toml} ~/.config


help:
	@echo 'Usage: make [target]'
	@echo
	@echo 'Targets:'
	@egrep '^(.+)\:\ ##\ (.+)' ${MAKEFILE_LIST} | column -t -c 2 -s ':#'
