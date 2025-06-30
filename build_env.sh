#!/bin/sh
# Sets up my development environment on a new machine.
# Usage: ./build_env.sh --no-sudo # to skip sudo commands.
set -e
# Check if sudo is required
if [ "$1" != "--no-sudo" ]; then
    if [ "$(id -u)" -ne 0 ]; then
        echo "This script requires sudo privileges. Please run it with sudo or prefix with --no-sudo to skip sudo commands."
        exit 1
    fi
fi

# Install dependencies if sudo is available
if [ "$(id -u)" -eq 0 ]; then
    echo "Installing dependencies..."
    sudo apt update
    sudo apt install -y zsh git curl wget build-essential
else
    echo "Skipping dependency installation as sudo is not available."
fi

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install miniforge if not already installed
if ! command -v conda &> /dev/null; then
    echo "Miniforge not found. Installing Miniforge..."
    curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
    zsh Miniforge3-${uname}-$(uname -m).sh
    rm Miniforge3-${uname}-$(uname -m).sh
    echo "Miniforge installed successfully."
else
    echo "Miniforge is already installed."
fi

# Install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
zsh ~/.fzf/install

# Install conda packages
conda install -y python numpy scipy scikit-learn matplotlib ipykernel scikit-image neovim

# Install neovim python package
python3 -m pip install --user --upgrade pynvim

# Apply the .vimrc configuration
echo "Applying .vimrc configuration..."
if [ -f .vimrc ]; then
    ln -s ~/.vimrc .vimrc
fi

# Apply the .zshrc configuration if it exists
echo "Applying .zshrc configuration..."
if [ -f .zshrc ]; then
    ln -s ~/.zshrc .zshrc
fi
