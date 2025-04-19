#!/bin/bash

# Download ~/.rosrc
if [[ -f ~/.rosrc ]]; then mv ~/.rosrc ~/.rosrc.stale.$(date +%Y%m%d%H%M%S.%s); fi
curl -s https://raw.githubusercontent.com/uniquetrij/rosrc/refs/heads/main/rosrc > ~/.rosrc
# Source the new ~/.rosrc
source ~/.rosrc
# Execute the installer
rosinstall
# Permanently add the source command to ~/.bashrc
grep -q "source ~/.rosrc" ~/.bashrc || echo "source ~/.rosrc" >> ~/.bashrc
