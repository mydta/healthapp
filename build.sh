#!/bin/sh

# Exit on errors
set -e

# Download and extract Flutter
curl -fsSL https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.19.0-stable.tar.xz | tar -xJ

# Add Flutter to PATH
export PATH="$PATH:`pwd`/flutter/bin"

# Fix ownership issue in Vercel
git config --global --add safe.directory /vercel/path0/flutter

# Ensure Flutter is installed and updated
flutter doctor
flutter upgrade

# Install dependencies
flutter pub get

# Build Flutter Web
flutter build web

# Rename the output folder to 'public' for Vercel
mv build/web public
