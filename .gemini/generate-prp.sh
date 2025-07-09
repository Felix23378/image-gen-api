#!/bin/bash

# Fail on any error
set -e

# --- CONFIG ---
# Get the absolute path to the project root
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PROJECT_ROOT=$(realpath "$SCRIPT_DIR/..")

# File paths
GEMINI_MD="$PROJECT_ROOT/GEMINI.md"
INITIAL_MD="$PROJECT_ROOT/INITIAL.md"
PRP_BASE_MD="$PROJECT_ROOT/.gemini/prp_base.md"

# Output directory
PRP_DIR="$PROJECT_ROOT/PRPs"

# --- VALIDATION ---
# Check if all required files exist
if ! [ -f "$GEMINI_MD" ]; then
    echo "❌ Error: GEMINI.md not found at $GEMINI_MD"
    exit 1
fi

if ! [ -f "$INITIAL_MD" ]; then
    echo "❌ Error: INITIAL.md not found at $INITIAL_MD"
    exit 1
fi

if ! [ -f "$PRP_BASE_MD" ]; then
    echo "❌ Error: prp_base.md not found at $PRP_BASE_MD"
    exit 1
fi

# --- SCRIPT ---
# 1. Read the PRP base template
PRP_CONTENT=$(<"$PRP_BASE_MD")

# 2. Read the context files
GEMINI_CONTEXT=$(<"$GEMINI_MD")
INITIAL_CONTEXT=$(<"$INITIAL_MD")

# 3. Combine into a single prompt
FULL_PROMPT="""
# PRP Base
$PRP_CONTENT

---

# GEMINI.md Context
$GEMINI_CONTEXT

---

# INITIAL.md Context
$INITIAL_CONTEXT
"""

# 4. Create a unique filename for the new PRP
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
OUTPUT_FILE="$PRP_DIR/PRP-$TIMESTAMP.md"

# 5. Write the combined content to the new file
echo "$FULL_PROMPT" > "$OUTPUT_FILE"

# 6. Success message
echo "✅ PRP generated successfully: $OUTPUT_FILE"
