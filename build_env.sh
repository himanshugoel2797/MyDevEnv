#!/bin/sh

sudo apt update
sudo apt install -y zsh git curl wget build-essential
# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install miniforge
curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
zsh Miniforge3-${uname}-$(uname -m).sh

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
