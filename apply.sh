#!/bin/sh

set -e

if [ -t 0 ]; then # Running interactively
    DEST_DIR=$(cd "$(dirname "$0")" && pwd)
else
    echo "Downloading and extracting repository..."
    GITHUB_USER="wiwiwa"
    GITHUB_REPO="Dotfiles"
    BRANCH="main"
    DEST_DIR="$HOME/.config/Dotfiles"

    mkdir -p "$DEST_DIR"
    curl -L "https://github.com/${GITHUB_USER}/${GITHUB_REPO}/archive/${BRANCH}.tar.gz" | tar -xz -C "$DEST_DIR" --strip-components=1
fi

# Apply dotfiles
echo "Applying dotfiles..."
for file in ${DEST_DIR}/dot/*; do
  destFile="$HOME/.$(basename "$file")"
  if [ ! -e "$destFile" ]; then
    echo "Creating link for $destFile..."
    ln -sf "$file" "$destFile"
  fi
done

echo "Dotfiles applied successfully."
