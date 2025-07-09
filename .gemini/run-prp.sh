#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# --- CONFIG ---
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PROJECT_ROOT=$(realpath "$SCRIPT_DIR/..")
PRP_DIR="$PROJECT_ROOT/PRPs"
RUN_PROMPT_PATH="$PROJECT_ROOT/.gemini/run.prompt"

# --- VALIDATION ---
if [ -z "$1" ]; then
    echo "❌ Error: Please provide the name of the PRP file to execute."
    echo "Usage: $0 <prp-file-name>"
    exit 1
fi

PRP_FILE_PATH="$PRP_DIR/$1"

if ! [ -f "$PRP_FILE_PATH" ]; then
    echo "❌ Error: PRP file not found at $PRP_FILE_PATH"
    exit 1
fi

if ! [ -f "$RUN_PROMPT_PATH" ]; then
    echo "❌ Error: Run prompt not found at $RUN_PROMPT_PATH"
    exit 1
fi

# --- SCRIPT ---
echo "▶️ Executing PRP: $1"

# 1. Load the run prompt and the specific PRP content
RUN_PROMPT=$(<"$RUN_PROMPT_PATH")
PRP_CONTENT=$(<"$PRP_FILE_PATH")

# 2. Combine them into a single prompt for the Gemini CLI
FULL_PROMPT="""$RUN_PROMPT

---

$PRP_CONTENT
"""

# 3. Send the prompt to Gemini CLI and capture the output
echo "⏳ Contacting Gemini CLI for implementation plan..."
GEMINI_OUTPUT=$(echo "$FULL_PROMPT" | gemini)

# 4. Parse and execute the response
# Use process substitution with a while loop for robust parsing.
# The loop reads blocks of text separated by the custom delimiter.
OLD_IFS=$IFS
IFS='
' # Ensure we can read lines with spaces

# Use awk to split the output into blocks based on the separator
# Then pipe each block to the while loop for processing
echo "$GEMINI_OUTPUT" | awk 'BEGIN{RS="<--BLOCK_SEPARATOR-->"} {gsub(/^\n*|\n*$/, ""); print $0}' | while read -r block; do
    if [ -z "$block" ]; then
        continue
    fi

    # Extract the first line (action + path) and the rest (code)
    ACTION_LINE=$(echo "$block" | head -n 1)
    CODE_CONTENT=$(echo "$block" | tail -n +2)

    ACTION=$(echo "$ACTION_LINE" | awk '{print $1}')
    FILE_PATH=$(echo "$ACTION_LINE" | awk '{print $2}')

    # Validate that we have an action and a path
    if [ -z "$ACTION" ] || [ -z "$FILE_PATH" ]; then
        echo "⚠️  Skipping malformed block:"
        echo "$block"
        continue
    fi

    # Display the proposed change
    echo "--------------------------------------------------"
    echo "Gemini proposes to $ACTION file: $PROJECT_ROOT/$FILE_PATH"
    echo "--- Code ---"
    echo "$CODE_CONTENT"
    echo "------------"

    # Confirm with the user
    read -p "Apply this change? [y/n] " -n 1 -r
    echo # Move to a new line

    if [[ $REPLY =~ ^[Yy]$ ]]; then
        # Ensure the target directory exists
        mkdir -p "$(dirname "$PROJECT_ROOT/$FILE_PATH")"

        # Write the file
        echo -e "$CODE_CONTENT" > "$PROJECT_ROOT/$FILE_PATH"
        echo "✅ Applied: $ACTION $FILE_PATH"
    else
        echo "Skipped."
    fi

done

IFS=$OLD_IFS
echo "--------------------------------------------------"
echo "✅ All actions from PRP '$1' have been processed."