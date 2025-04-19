#!/bin/sh

# Ensure curl is installed
sudo apt update && sudo apt install --reinstall -y curl
if [ -f ~/.rosrc ]; then mv ~/.rosrc ~/.rosrc.stale.$(date +%Y%m%d%H%M%S.%s); fi
curl -s https://raw.githubusercontent.com/uniquetrij/rosrc/refs/heads/main/rosrc > ~/.rosrc
grep -q "source ~/.rosrc" ~/.bashrc || echo "source ~/.rosrc" >> ~/.bashrc
bash -c "source ~/.rosrc && rosinstall"
