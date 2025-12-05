#!/usr/bin/env bash

sudo apt update -y
sudo apt install -y \
    python3 \
    python3-pip \
    python3-venv \
    python3-dev \
    gcc \
    ripgrep \
    fzf \
    git \
    curl \
    wget \
    unzip \
    ca-certificates \
    fontconfig \
    ninja-build \
    gettext \
    libtool \
    libtool-bin \
    autoconf \
    automake \
    cmake \
    g++ \
    pkg-config \
    npm

cd /tmp
git clone https://github.com/neovim/neovim.git
cd neovim
git checkout stable
make CMAKE_BUILD_TYPE=Release
if [[ $? -ne 0 ]]; then
    echo "Error: Failed to build Neovim from source."
    exit 1
fi
sudo make install
if [[ $? -ne 0 ]]; then
    echo "Error: Failed to install Neovim."
    exit 1
fi
nvim --version || { echo "Error: Neovim installation failed."; exit 1; }

mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
if [[ $? -ne 0 ]]; then
    echo "Error: Failed to download JetBrains Mono font."
    exit 1
fi
unzip -q JetBrainsMono.zip
rm JetBrainsMono.zip
fc-cache -fv || { echo "Error: Failed to update font cache."; exit 1; }

cd ~/.config
git clone https://github.com/yellowkappa22/nvim

pip install -r ~/vm_setup/vm_pyreq.txt
