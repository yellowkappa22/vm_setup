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
    fontconfig

echo "Downloading and installing Neovim 0.11+..."
cd /tmp
wget -q https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
if [[ $? -ne 0 ]]; then
    echo "Error: Failed to download Neovim AppImage."
    exit 1
fi
chmod u+x nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim
if [[ $? -ne 0 ]]; then
    echo "Error: Failed to move Neovim AppImage to /usr/local/bin."
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

