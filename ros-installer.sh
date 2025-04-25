#!/bin/sh

# Ensure curl is installed
sudo apt update && sudo apt install --reinstall -y curl

# Backup existing .rosrc file if it exists, appending a timestamp to the backup
if [ -f ~/.rosrc ]; then
  mv ~/.rosrc ~/.rosrc.stale.$(date +%Y%m%d%H%M%S.%s)
fi

# Check if running in a CI environment and if required environment variables are set
if [ -z "$CI" ] || [ -z "$GITHUB_RUN_ID" ]; then
  branch=main
else
  # Define the API URL and authorization header
  GITHUB_API_URL="https://api.github.com/repos/$GITHUB_REPOSITORY/actions/runs/$GITHUB_RUN_ID"
  AUTH_HEADER="Authorization: Bearer $GITHUB_TOKEN"

  # Make the API request
  response=$(curl -s -H "$AUTH_HEADER" "$GITHUB_API_URL")
  status_code=$(echo "$response" | jq -r '.status_code')
  workflow_runs=$(echo "$response" | jq -r '.workflow_runs')
  # Check if the response is valid
  if [ "$status_code" -eq 200 ] && [ "$workflow_runs" != "null" ]; then
    branch=$(echo "$response" | jq -r '.head_branch')
  else
    branch=main
  fi
fi

echo "Branch: $branch"

# Download the latest version of the rosrc file from the GitHub repository
curl -s https://raw.githubusercontent.com/uniquetrij/rosrc/refs/heads/$branch/rosrc >~/.rosrc

# Add a command to source the .rosrc file in .bashrc if it is not already present
grep -q "source ~/.rosrc" ~/.bashrc || echo "source ~/.rosrc" >>~/.bashrc

# Source the .rosrc file and run the rosinstall command
bash -c "source ~/.rosrc && rosinstall"

# Download and execute the extrc-installer.sh script from the GitHub repository
curl -s https://raw.githubusercontent.com/uniquetrij/bashrc-extensions/refs/heads/main/extrc-installer.sh | sh

# Reload bash shell
bash
