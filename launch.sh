#!/usr/bin/env bash

function install_packages() {
    echo "Installing packages..." | tee -a install.log
    sudo apt-get update &>> install.log

    sudo apt-get install\
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
        &>> install.log

    # Install neovim and set the proper alternatives.
    sudo pip3 install neovim &>> install.log
    sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 80 &>> install.log
    sudo update-alternatives --set vim /usr/bin/nvim &>> install.log

    # Install rust.
    curl https://sh.rustup.rs -sSf | sh -s -- -y --no-modify-path &>> install.log
}

function make_symlinks() {
    echo "Making symlinks..." | tee -a install.log
    for f in ~/dotfiles/home/.*; do
        if [ -f "$f" ]; then
            echo "Creating symlink to $(basename $f)" &>> install.log
            ln -sf "$f" "$HOME/$(basename "$f")" &>> install.log
        fi
    done
}

function install_plugins() {
    echo "Installing plugins..." | tee -a install.log

    # Install zprezto.
    if [ -e ~/.zprezto ]; then
        rm -rf ~/.zprezto
    fi
    git clone https://github.com/sorin-ionescu/prezto.git ~/.zprezto &>> install.log

    (
    cd ~/.zprezto
    git submodule update --init --recursive &>> install.log
    )

    # Install tmux plugins.
    if [ -e ~/.tmux/plugins/tpm ]; then
        rm -rf ~/.tmux/plugins/tpm
    fi
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm &>> install.log
    ~/.tmux/plugins/tpm/bin/update_plugins all

    # Install all vim plugins in ex mode.
    vim +PlugInstall! +qall

    # Change shell to zsh
    chsh -s $(which zsh)
    sudo chsh -s $(which zsh)
}

set -e

rm -f install.log
git pull &> /dev/null
install_packages
make_symlinks
install_plugins

echo "Done!"
