#!/bin/sh

# Check if running Ubuntu 24.04 or later
if [ "$(lsb_release -si)" != "Ubuntu" ] || [ "$(lsb_release -rs | cut -d. -f1)" -lt 24 ] || { [ "$(lsb_release -rs | cut -d. -f1)" -eq 24 ] && [ "$(lsb_release -rs | cut -d. -f2)" -lt 4 ]; }; then
  echo "This script is intended for Ubuntu 24.04 LTS or later only."
  exit 1
fi

# Ensure curl is installed
sudo apt update && sudo apt install --reinstall -y curl

# Backup existing .rosrc file if it exists, appending a timestamp to the backup
if [ -f ~/.rosrc ]; then
  mv ~/.rosrc ~/.rosrc.stale.$(date +%Y%m%d%H%M%S.%s)
fi

# Download the latest version of the rosrc file from the GitHub repository
curl -s https://raw.githubusercontent.com/uniquetrij/rosrc/refs/heads/${ROSRC_GIT_BRANCH:-main}/rosrc >~/.rosrc

# Add a command to source the .rosrc file in .bashrc if it is not already present
grep -q "source ~/.rosrc" ~/.bashrc || echo "source ~/.rosrc" >>~/.bashrc

# Source the .rosrc file and run the rosinstall command
bash -c "source ~/.rosrc && rosinstall"

# Download and execute the extrc-installer.sh script from the GitHub repository
curl -s https://raw.githubusercontent.com/uniquetrij/bashrc-extensions/refs/heads/main/extrc-installer.sh | sh

echo "==> For changes to take effect, it is recommended to close and re-open your current shell. <=="
