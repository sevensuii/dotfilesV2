# Makefile para manejar la configuración de los dotfiles

.DEFAULT_GOAL := help

# Old fonts instalation
#&& paru -S nerd-fonts-cascadia-code nerd-fonts-fantasque-sans-mono nerd-fonts-jetbrains-mono nerd-fonts-roboto-mono nerd-fonts-ubuntu

CONFIG=alacritty,dunst,fish,kitty,neofetch,picom,polybar,qtile,rofi,starship.toml,ranger,tmux,nvim

## WM commands


## Dotfiles commands
install-symbolic-config: ## Copies repo folders to .config using symbolic links
	@echo 'Sym linking dotfiles' \
        	&& cp -srf ~/git_repos/dotfilesV2/{$(CONFIG)} ~/.config

install-copy-config: ## Copies repo folders to .config
	@echo 'Copying dotfiles' \
		&& cp -rf ~/git_repos/dotfilesV2/{$(CONFIG)} ~/.config

install-paru: ## Installs Paru AUR helper
	@echo 'Installing Paru' \
		&& mkdir -p ~/git_repos \
		&& git clone https://aur.archlinux.org/paru.git ~/git_repos/paru || true \
		&& cd ~/git_repos/paru \
		&& makepkg -si

install-fonts: ## Installs every font used
	@echo 'Installing fonts' \
		&& sudo pacman -S ttf-cascadia-code-nerd ttf-fantasque-nerd ttf-jetbrains-mono-nerd ttf-roboto-mono-nerd ttf-ubuntu-nerd

install-aur-packages: ## Installs necessary AUR packages
	@echo 'Installing AUR packages' \
		&& paru -S lsd exa cpupower-gui pfetch cava dry-bin google-chrome brave-bin shell-color-scripts

install-arch-packages: ## Installs necessary packages from oficial repositories
	@echo 'Installing arch packages' \
		&& sudo pacman -Syyu neofetch htop nitrogen fish rofi qtile dunst python-dbus p7zip unzip tar python-pip \
		papirus-icon-theme cmatrix feh pavucontrol alacritty kitty git vim neovim curl flameshot playerctl brightnessctl bc bashtop acpi \
		wget shfmt lxsession nautilus starship php composer nano network-manager-applet openvpn gnome-keyring sysstat xdotool arandr firefox \
		calcurse picom polybar ranger ueberzug discord telegram-desktop cameractrls tmux sshpass ripgrep npm ruby rubygems lazygit debugedit xclip \
		&& gem install timetrap

install-basic-packages: ## Installs stuff like xorg...
	@echo 'Installing basic stuff' \
		&& sudo pacman -S linux-headers base base-devel alsa-utils

install-tmux-conf: ## Setups necessary repos for tmux
	@echo 'Cloning tmux-tpm' \
		&& git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm \
		&& echo 'Open tmux and execute prefix + I'

install-snapd: ## Installs snapd for snap packages
	@echo 'Installing snapd' \
		&& mkdir -p ~/git_repos \
		&& git clone https://aur.archlinux.org/snapd.git ~/git_repos/snapd || true \
		&& cd ~/git_repos/snapd \
		&& makepkg -si \
		&& sudo systemctl enable --now snapd.socket \
		&& sudo systemctl start snapd \
		&& sudo ln -s /var/lib/snapd/snap /snap

install-snapd-packages: ## Installs snapd packages
	@echo 'Installing snapd packages' \
		&& sudo snap install phpstorm --classic \
		&& sudo snap install code --classic \
		&& sudo snap install youtube-music-desktop-app

install-docker: ## Installs and configures docker
	@echo 'Installing docker' \
		&& sudo pacman -S containerd docker docker-buildx docker-compose \
		&& sudo groupadd docker || true \
		&& echo 'Adding user to docker group' \
		&& sudo usermod -aG docker $(USER) \
		&& echo 'Please re-login into the system'

install-all-paru: install-paru install-aur-packages ## Executes all paru related commands
	
install-all-snapd: install-snapd install-snapd-packages ## Executes all snapd related commands

setup-everything: install-symbolic-config install-arch-packages install-docker install-fonts install-aur-packages install-all-snapd ## Setup as everything should be

help:
	@echo 'Usage: make [target]'
	@echo
	@echo 'Targets:'
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
