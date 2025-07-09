#!/bin/bash

# Fail on any error
set -e

# --- CONFIG ---
# Get the absolute path to the project root
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PROJECT_ROOT=$(realpath "$SCRIPT_DIR/..")

# PRP directory
PRP_DIR="$PROJECT_ROOT/PRPs"

# --- VALIDATION ---
# Check if a PRP name is provided
if [ -z "$1" ]; then
    echo "❌ Error: Please provide the name of the PRP file to execute."
    echo "Usage: $0 <prp-file-name>"
    exit 1
fi

PRP_FILE_PATH="$PRP_DIR/$1"

# Check if the PRP file exists
if ! [ -f "$PRP_FILE_PATH" ]; then
    echo "❌ Error: PRP file not found at $PRP_FILE_PATH"
    exit 1
fi

# --- SCRIPT ---
# 1. Read the PRP content
PRP_CONTENT=$(<"$PRP_FILE_PATH")

# 2. TODO: Replace the command below with the actual command to execute the PRP
# For now, this script will just print the content of the PRP file.
echo "--- Executing PRP: $1 ---"
echo "$PRP_CONTENT"
echo "--- End of PRP ---"


# 3. Success message
echo "✅ PRP file '$1' executed successfully."
