#!/bin/sh

sudo apt update
sudo apt install python3 python3-pip cargo nodejs npm

# Install neovim
sudo apt install neovim
sudo apt install python3-neovim

sudo apt install fasd
sudo npm install -g tldr
sudo apt install mosh
sudo apt install direnv

cargo install lsd
cargo install bat

pip install thefuck

#Add ~/.cargo/bin to PATH in .bashrc
echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.bashrc
#Add direnv hook to .bashrc
echo 'eval "$(direnv hook bash)"' >> ~/.bashrc
