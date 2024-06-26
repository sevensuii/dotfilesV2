if status is-interactive
    and not set -q TMUX
    tmux
end

if status is-interactive
    # Run "neofetch" for System info everytime fish is opened
    #neofetch

    # Run "pfetch" for System info everytime fish is opened
    # pfetch

    # Adding the Path for ST-Development Folder
    set -gx fish_user_paths ~/.local/bin/ ~/.local/share/nvim/lsp_servers/python/node_modules/.bin ~/.local/share/nvim/lsp_servers/rust ~/.cargo/bin ~/.local/share/nvim/lsp_servers/sumneko_lua/extension/server/bin
    set -gx LD_LIBRARY_PATH /usr/local/lib

    # Adding the Path for ST-Development Folder in the bashrc format
    #export PATH=$PATH:$HOME/ST-Development/stlink-1.7.0/

    # Export the editor for Ranger
    export EDITOR='vim'
    export VISUAL='vim'

    # Disable fish_greeting
    set fish_greeting

    # Adding Aliases
    #alias ll="ls -lah --color=auto"
    alias ll="lsd -lah"
    alias ls="exa --icons"
    #alias vpnLcr="sudo openvpn --config ~/.vpn/dpto.sistemas__ssl_vpn_config.ovpn --auth-user-pass ~/.vpn/pass.txt"
    alias vpnLcr="sudo openvpn --config ~/.vpn/LCRcom_severyn.dorosh__ssl_vpn_config.ovpn --auth-user-pass ~/.vpn/pass.txt"
    ## For tmux sessions
    #    alias cmt='bash -c '\''exec -a cmtt cmatrix "$@"'\'' cmt1'
    alias push-redmines="cd ~/Documentos/redmine_doc/ && git add * && git commit -m 'new docs' && git push"
    alias pull-redmines="cd ~/Documentos/redmine_doc/ && git pull"
    alias redmines="cd ~/Documentos/redmine_doc/ && ranger"
    abbr -a nredmine --set-cursor -- "nvim RM%.md"

    alias lgit="lazygit"
    abbr -a ktw --set-cursor -- "icat (~/Documentos/unsorted-wallpapers/print_random_wallpaper.py h%)"
    abbr -a cktw --set-cursor -- "clear && icat (~/Documentos/unsorted-wallpapers/print_random_wallpaper.py h%)"


    # Aliases
    if [ -f $HOME/.lcra ]
        source $HOME/.lcra
    end

    alias nheos='cd /home/heos && nvim'
    alias ndeimos='cd /app/deimos && nvim'
    alias ngea='cd /app/gea && nvim'
    alias ndotfiles='cd ~/git_repos/dotfilesV2 && nvim'

    #DOCKER
    alias heos='docker exec -it --user heos heos bash'
    alias heos-run='docker exec -it --user heos heos '

    # VSCODE alias workspace
    # alias code-heos='code ~/heos.code-workspace'
    # alias code-deimos='code ~/deimos.code-workspace'
    # alias code-gea='code ~/gea.code-workspace'

    # Kitty term Aliases
    alias icat="kitty +kitten icat"

    # Keeps temps in line
    alias lte='sudo ryzenadj -f 80'

    # TIMETRAP: ALIASES AND FISH ABBREVIATIONS
    alias tt='clear && t today --ids'
    #alias tin='t in $1 && tt'
    alias tout='clear && t out && tt'
    abbr -a tin --set-cursor -- "clear && t in % && tt"



    #set -U fish_color_param blue
    #set fish_greeting

    # Starting the starship prompt
    starship init fish | source

    export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
    export PATH="$PATH:$GEM_HOME/bin"
end
