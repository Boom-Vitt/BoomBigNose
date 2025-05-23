#!/bin/bash

# This script initializes a Git repository and pushes it to GitHub
# Usage: ./init-repo.sh <github-username>

if [ -z "$1" ]; then
  echo "Please provide your GitHub username"
  echo "Usage: ./init-repo.sh <github-username>"
  exit 1
fi

GITHUB_USERNAME=$1
REPO_NAME="nca-toolkit-railway-template"

# Initialize Git repository
git init
git add .
git commit -m "Initial commit: NCA-Toolkit Railway Template"

# Create GitHub repository
echo "Creating GitHub repository: $GITHUB_USERNAME/$REPO_NAME"
echo "Please enter your GitHub Personal Access Token:"
read -s GITHUB_TOKEN

curl -u "$GITHUB_USERNAME:$GITHUB_TOKEN" https://api.github.com/user/repos -d "{\"name\":\"$REPO_NAME\", \"description\":\"Railway template for NCA-Toolkit with MinIO and Kokoro TTS\"}"

# Add remote and push
git remote add origin "https://github.com/$GITHUB_USERNAME/$REPO_NAME.git"
git branch -M main
git push -u origin main

echo "Repository initialized and pushed to GitHub: https://github.com/$GITHUB_USERNAME/$REPO_NAME"
echo "Next steps:"
echo "1. Go to Railway.app and create a new template from your GitHub repository"
echo "2. Update the README.md with your Railway template ID"
echo "3. Share your template with others!"
