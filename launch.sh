#!/usr/bin/env bash

function install_packages() {
    echo "Installing packages..." | tee -a install.log
    sudo apt update

    sudo apt install -y\
        ack-grep \
        bash \
        curl \
        git \
        htop \
        nmap \
        mosh \
        most \
        python3 \
        python3-pip \
        python-pycurl \
        python3 \
        vim \
        tmux \
        wget \
        zsh \
        neovim \
        terminator \


    # Install neovim and set the proper alternatives.
    sudo pip3 install neovim
    sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 80
    sudo update-alternatives --set vim /usr/bin/nvim

    # Install rust.
    curl https://sh.rustup.rs -sSf | sh -s -- -y --no-modify-path
}

function make_symlinks() {
    echo "Making symlinks..." | tee -a install.log
    for f in $(find ~/dotfiles/home/ -type f); do
        if [ ! -f "$f" ]; then
            continue
        fi

        after_home="${f##~/dotfiles/home/}"
        local_path="$HOME/$after_home"
        echo "Creating symlink for $local_path"

        mkdir -p $(dirname $local_path)
        ln -sf "$f" "$local_path"
    done
}

function install_plugins() {
    echo "Installing plugins..."

    # Install ohmyzsh.
    if [ -e ~/.oh-my-zsh ]; then
        rm -rf ~/.oh-my-zsh
    fi


    echo "Changing shell to zsh..."
    # Change shell to zsh
    chsh -s $(which zsh)
    sudo chsh -s $(which zsh)

    (
    echo "Installing ohmyzsh..."
    ZSH=~/.oh-my-zsh
    git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git $ZSH
    )

    (
      cd ~/.oh-my-zsh/custom/plugins
      # Install zsh-syntax-highlighting for ohmyzsh
      git clone git://github.com/zsh-users/zsh-syntax-highlighting.git

      # Install zsh-autosugestions for ohmyzsh
      git clone https://github.com/zsh-users/zsh-autosuggestions
    )


    # Install tmux plugins.
    if [ -e ~/.tmux/plugins/tpm ]; then
        rm -rf ~/.tmux/plugins/tpm
    fi

    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    ~/.tmux/plugins/tpm/bin/update_plugins all

    # Install all vim plugins in ex mode.
    vim +PlugInstall! +qall
}

set -e

git pull &> /dev/null
install_packages
make_symlinks
install_plugins

echo "Done!"
