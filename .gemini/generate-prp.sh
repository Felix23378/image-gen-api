#!/bin/bash

# Fail on any error
set -e

# --- CONFIG ---
# Get the absolute path to the project root
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PROJECT_ROOT=$(realpath "$SCRIPT_DIR/..")

# --- VALIDATION ---
# Check for feature name argument
if [ -z "$1" ]; then
    echo "❌ Error: Missing feature name."
    echo "Usage: $0 <feature_name>"
    exit 1
fi

FEATURE_NAME=$1

# File paths
GEMINI_MD="$PROJECT_ROOT/GEMINI.md"
INITIAL_MD="$PROJECT_ROOT/INITIAL_${FEATURE_NAME}.md"
PRP_BASE_MD="$PROJECT_ROOT/.gemini/prp_base.md"
PRP_FILL_PROMPT="$PROJECT_ROOT/.gemini/prp_fill.prompt"
PRP_DIR="$PROJECT_ROOT/PRPs"
OUTPUT_FILE="$PRP_DIR/prp_${FEATURE_NAME}.md"

# Check if all required files exist
if ! [ -f "$GEMINI_MD" ]; then
    echo "❌ Error: GEMINI.md not found at $GEMINI_MD"
    exit 1
fi

if ! [ -f "$INITIAL_MD" ]; then
    echo "❌ Error: INITIAL_${FEATURE_NAME}.md not found at $INITIAL_MD"
    exit 1
fi

if ! [ -f "$PRP_BASE_MD" ]; then
    echo "❌ Error: prp_base.md not found at $PRP_BASE_MD"
    exit 1
fi

if ! [ -f "$PRP_FILL_PROMPT" ]; then
    echo "❌ Error: prp_fill.prompt not found at $PRP_FILL_PROMPT"
    exit 1
fi

# --- SCRIPT ---
# 1. Read the context and template files
FILL_INSTRUCTIONS=$(<"$PRP_FILL_PROMPT")
PRP_BASE_CONTENT=$(<"$PRP_BASE_MD")
GEMINI_CONTEXT=$(<"$GEMINI_MD")
INITIAL_CONTEXT=$(<"$INITIAL_MD")

# 2. Combine into a single prompt for the Gemini CLI
# The Gemini CLI will receive instructions first, then the template to fill,
# and finally the context to use for filling the template.
FULL_PROMPT="""$FILL_INSTRUCTIONS

## PRP Template To Fill

$PRP_BASE_CONTENT

---

## Context: User Feature Request

$INITIAL_CONTEXT

---

## Context: Project Rules

$GEMINI_CONTEXT
"""

# 3. Create the output directory if it doesn't exist
mkdir -p "$PRP_DIR"

# 4. Generate the PRP by sending the combined prompt to the Gemini CLI
#    and save the output to the destination file.
#    (This assumes 'gemini' is a command available in the path)
echo "⏳ Generating PRP for feature '$FEATURE_NAME'..."
echo "$FULL_PROMPT" | gemini --model gemini-2.5-flash > "$OUTPUT_FILE"

# 5. Success message
echo "✅ PRP generated successfully: $OUTPUT_FILE"