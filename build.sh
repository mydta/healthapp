#!/bin/bash

# Exit on errors and print commands
set -ex

# Debugging: Print working directory
pwd

# Ensure Flutter is installed via Git (avoids Git clone error)
if [ ! -d "flutter" ]; then
  echo "Flutter not found. Cloning from GitHub..."
  git clone https://github.com/flutter/flutter.git -b stable --depth 1
else
  echo "Flutter is already installed"
fi

# Set Flutter path
export PATH="$PATH:`pwd`/flutter/bin"

# Debugging: Verify Flutter installation
flutter doctor || { echo "Flutter installation failed"; exit 1; }

# Install dependencies
flutter pub get || { echo "Flutter package install failed"; exit 1; }

# Enable web support
flutter config --enable-web || { echo "Failed to enable web support"; exit 1; }

# Build Flutter Web
flutter build web --release || { echo "Flutter build failed"; exit 1; }

# Ensure old 'public/' directory is removed before moving the new build
rm -rf public || { echo "Failed to remove old public directory"; exit 1; }
mv build/web public || { echo "Failed to move build/web to public"; exit 1; }

# Debugging: List files in 'public' to ensure the move was successful
ls -la public/ || { echo "Failed to list public directory"; exit 1; }
