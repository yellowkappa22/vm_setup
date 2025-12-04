#!/usr/bin/env bash

echo "Updating package list and installing essential tools..."
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
    pkg-config

echo "Cloning Neovim repository..."
cd /tmp
git clone https://github.com/neovim/neovim.git
cd neovim

echo "Checking out the latest stable release..."
git checkout stable

echo "Building Neovim from source..."
make CMAKE_BUILD_TYPE=Release
if [[ $? -ne 0 ]]; then
    echo "Error: Failed to build Neovim from source."
    exit 1
fi

echo "Installing Neovim..."
sudo make install
if [[ $? -ne 0 ]]; then
    echo "Error: Failed to install Neovim."
    exit 1
fi

echo "Verifying Neovim installation..."
nvim --version || { echo "Error: Neovim installation failed."; exit 1; }

echo "Downloading and installing Nerd Fonts (JetBrainsMono)..."
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
if [[ $? -ne 0 ]]; then
    echo "Error: Failed to download JetBrains Mono font."
    exit 1
fi
unzip -q JetBrainsMono.zip
rm JetBrainsMono.zip

echo "Updating font cache..."
fc-cache -fv || { echo "Error: Failed to update font cache."; exit 1; }

echo "Setup complete! Neovim and Nerd Fonts installed successfully."
