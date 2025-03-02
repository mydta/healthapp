#!/bin/sh

# Exit on errors
set -e

# Debugging: Print working directory
pwd

# Ensure Flutter is installed (if not, download it)
if [ ! -d "flutter" ]; then
  echo "Flutter not found. Downloading..."
  curl -fsSL https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.29.0-stable.tar.xz | tar -xJ
else
  echo "Flutter is already installed"
fi

# Set Flutter path
export PATH="$PATH:`pwd`/flutter/bin"

# Debugging: Verify Flutter installation
flutter doctor || echo "Flutter installation failed"

# Install dependencies
flutter pub get

# Enable web support
flutter config --enable-web

# Build Flutter Web
flutter build web --release

# Ensure old 'public/' directory is removed before moving the new build
rm -rf public
mv build/web public

# Debugging: List files in 'public' to ensure the move was successful
ls -la public/
