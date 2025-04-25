#!/bin/sh

# Ensure curl is installed
sudo apt update && sudo apt install --reinstall -y curl

# Backup existing .rosrc file if it exists, appending a timestamp to the backup
if [ -f ~/.rosrc ]; then
  mv ~/.rosrc ~/.rosrc.stale.$(date +%Y%m%d%H%M%S.%s)
fi

# Download the latest version of the rosrc file from the GitHub repository
curl -s https://raw.githubusercontent.com/uniquetrij/rosrc/refs/heads/${branch:-main}/rosrc >~/.rosrc

# Add a command to source the .rosrc file in .bashrc if it is not already present
grep -q "source ~/.rosrc" ~/.bashrc || echo "source ~/.rosrc" >>~/.bashrc

# Source the .rosrc file and run the rosinstall command
bash -c "source ~/.rosrc && rosinstall"

# Download and execute the extrc-installer.sh script from the GitHub repository
curl -s https://raw.githubusercontent.com/uniquetrij/bashrc-extensions/refs/heads/main/extrc-installer.sh | sh

echo "==> For changes to take effect, it is best to close and re-open your current shell. <=="

# Start bash shell
bash 
