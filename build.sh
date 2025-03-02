#!/bin/sh

# Exit on errors
set -e

# Debugging: Print working directory
pwd

# Check if Flutter is already installed to avoid unnecessary downloads
if [ ! -d "flutter" ]; then
  echo "Flutter not found. Downloading..."
  curl -fsSL https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.19.0-stable.tar.xz | tar -xJ
fi

# Add Flutter to PATH
export PATH="$PATH:`pwd`/flutter/bin"

# Ensure Flutter is installed
flutter doctor

# Use a fixed version of Flutter instead of upgrading every time (recommended)
flutter --version

# Install dependencies
flutter pub get

# Enable web support (only needed once, remove if already configured)
flutter config --enable-web

# Build Flutter Web
flutter build web --release

# Ensure old 'public/' directory is removed before moving the new build
rm -rf public

# Rename the output folder to 'public' for Vercel
mv build/web public

# Debugging: List files in 'public' to ensure the move was successful
ls -la public/
