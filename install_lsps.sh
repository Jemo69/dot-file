#!/bin/bash

# Update package list
pkg update

# Install language servers
pkg install -y rust-analyzer
pkg install -y python-pyright
pkg install -y openjdk-17
pkg install -y nodejs
npm install -g typescript-language-server
npm install -g @tailwindcss/language-server
npm install -g svelte-language-server
pkg install -y dart
pkg install -y go

# Clean up npm cache
npm cache clean --force

# Make the script executable
chmod +x install_lsps.sh

echo "All LSP servers have been installed."
