#!/bin/sh

# Download the latest ~/.rosrc
if [ -f ~/.rosrc ]; then mv ~/.rosrc ~/.rosrc.stale.$(date +%Y%m%d%H%M%S.%s); fi
curl -s https://raw.githubusercontent.com/uniquetrij/rosrc/refs/heads/main/rosrc > ~/.rosrc
# Source it into your ~/.bashrc if not already done
grep -q "source ~/.rosrc" ~/.bashrc || echo "source ~/.rosrc" >> ~/.bashrc
# Refresh your bash
source ~/.bashrc
# Execute the installer
rosinstall