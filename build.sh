#!/bin/sh

# Download and extract Flutter
curl -fsSL https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.19.0-stable.tar.xz | tar -xJ

# Add Flutter to PATH
export PATH="$PATH:`pwd`/flutter/bin"

# Fix dubious ownership error
git config --global --add safe.directory /vercel/path0/flutter

# Ensure Flutter is installed and updated
flutter doctor --no-root
flutter upgrade --no-root

# Get dependencies
flutter pub get --no-root

# Build the Flutter Web app
flutter build web
