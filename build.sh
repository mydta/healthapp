#!/bin/sh

# Exit on errors
set -e

# Debugging: Print working directory
pwd

# Ensure Flutter is downloaded and installed
if [ ! -d "flutter" ]; then
  echo "Flutter not found. Downloading..."
  curl -fsSL https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.19.0-stable.tar.xz | tar -xJ
fi

# Set Flutter path
export PATH="$PATH:`pwd`/flutter/bin"

# Check Flutter installation
flutter doctor || echo "Flutter failed to install"

# Install dependencies
flutter pub get

# Enable web support
flutter config --enable-web

# Build Flutter Web
flutter build web --release

# Remove existing public folder and move the new build
rm -rf public
mv build/web public

# Debugging: List files in 'public' to ensure the move was successful
ls -la public/
