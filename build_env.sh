#!/bin/sh
# Sets up my development environment on a new machine.
# Usage: ./build_env.sh --skip-conda # to skip conda package installation.
set -e

PWD=$(pwd)

# Install dependencies if sudo is available
if [ "$(id -u)" -eq 0 ]; then
    echo "Installing dependencies..."
    sudo apt update
    sudo apt install -y zsh git curl wget build-essential
else
    echo "Skipping dependency installation as sudo is not available."
fi

# Install oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "oh-my-zsh is already installed."
fi

# Install miniforge if not already installed
if [ "$1" = "--skip-conda" ]; then
    echo "Skipping Miniforge installation as requested."
elif [ -d "$HOME/miniforge3" ]; then
    echo "Miniforge is already installed."
else
    echo "Installing Miniforge..."
    curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
    zsh Miniforge3-$(uname)-$(uname -m).sh
    rm Miniforge3-$(uname)-$(uname -m).sh
    echo "Miniforge installed successfully."
fi

# Install fzf
if [ ! -d "$HOME/.fzf" ]; then
    echo "Installing fzf..."
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    zsh ~/.fzf/install
else
    echo "fzf is already installed."
fi

# Install conda packages into the base environment
# Skip this step if --skip-conda is passed
if [ "$1" = "--skip-conda" ]; then
    echo "Skipping conda package installation as requested."
else
    echo "Installing conda packages..."
    # Create base environment if it doesn't exist
    if ! conda info --envs | grep -q "base"; then
        conda create -y -n base python numpy scipy scikit-learn matplotlib ipykernel scikit-image
    fi
fi

# Install neovim python package
#python3 -m pip install --user --upgrade pynvim

# Install vim-plug if not already installed
if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
    echo "Installing vim-plug..."
    mkdir -p "$HOME/.vim/autoload"
    curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
    echo "vim-plug is already installed."
fi

# Apply the .vimrc configuration
echo "Applying .vimrc configuration..."
if [ ! -e ~/.vimrc ]; then
    ln -s $PWD/.vimrc ~/.vimrc
else
    echo ".vimrc already exists, skipping symlink creation."
fi

# Apply the .zshrc configuration if it exists
echo "Applying .zshrc configuration..."
if [ ! -e ~/.zshrc ]; then
    ln -s $PWD/.zshrc ~/.zshrc
else
    echo ".zshrc already exists, skipping symlink creation."
fi
