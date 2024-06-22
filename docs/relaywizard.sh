#!/bin/bash

# URL to download the relaywiz binary
RELAYWIZ_URL="https://github.com/nodetec/relaywizard/releases/download/v0.0.1/relaywiz"

# Destination path for the downloaded binary
DEST_PATH="/usr/local/bin/relaywiz"

# Download the relaywiz binary
echo "Downloading relaywiz from $RELAYWIZ_URL..."
curl -L -o "$DEST_PATH" "$RELAYWIZ_URL"

# Make the binary executable
echo "Making relaywiz executable..."
chmod +x "$DEST_PATH"

# Run the relaywiz install command
echo "Running relaywiz install..."
"$DEST_PATH" install < /dev/tty

