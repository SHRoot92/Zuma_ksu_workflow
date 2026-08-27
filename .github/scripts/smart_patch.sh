#!/usr/bin/env bash
# smart_patch.sh - Automated Multi-Strategy Kernel & KSU Patch Applier with Self-Healing

set -o pipefail

PATCH_FILE="$1"
TARGET_DIR="${2:-.}"
DESCRIPTION="${3:-$(basename "$PATCH_FILE")}"

if [ -z "$PATCH_FILE" ]; then
    echo "❌ Usage: smart_patch.sh <patch_path> [target_dir] [description]"
    exit 1
fi

if [ ! -f "$PATCH_FILE" ]; then
    echo "❌ Error: Patch file '$PATCH_FILE' not found!"
    exit 1
fi

echo "🔧 [smart_patch] Applying patch: $DESCRIPTION"
echo "   - Patch File: $PATCH_FILE"
echo "   - Target Directory: $TARGET_DIR"

cd "$TARGET_DIR" || exit 1

# Check if patch is already applied
if git apply --check --reverse "$PATCH_FILE" >/dev/null 2>&1 || patch -p1 -R --dry-run < "$PATCH_FILE" >/dev/null 2>&1; then
    echo "   ✅ Patch is already applied, skipping."
    exit 0
fi

# Strategy 1: Standard git apply (Fast & clean)
if git apply --ignore-space-change --ignore-whitespace "$PATCH_FILE" 2>/dev/null; then
    echo "   ✅ Applied successfully via Strategy 1 (git apply)"
    exit 0
fi

# Strategy 2: Git 3-Way Merge (Resolves context line shifts automatically)
if git apply --3way --ignore-space-change --ignore-whitespace "$PATCH_FILE" 2>/dev/null; then
    echo "   ✅ Applied successfully via Strategy 2 (git apply 3-way merge)"
    exit 0
fi

# Strategy 3: Loose Patch with Fuzz Factor 3 & Line Normalization
if patch -p1 -N -l --fuzz=3 < "$PATCH_FILE"; then
    echo "   ✅ Applied successfully via Strategy 3 (patch with fuzz=3)"
    rm -f ./*.rej ./*/*.rej ./*/*/*.rej 2>/dev/null || true
    exit 0
fi

# Strategy 4: Fallback to loose reverse line-ending patch
if tr -d '\r' < "$PATCH_FILE" | patch -p1 -N -l --fuzz=3; then
    echo "   ✅ Applied successfully via Strategy 4 (patch normalized CRLF)"
    rm -f ./*.rej ./*/*.rej ./*/*/*.rej 2>/dev/null || true
    exit 0
fi

echo "❌ [smart_patch] All automatic strategies failed for: $DESCRIPTION"

# Report rejected files for debugging
REJECTS=$(find . -name "*.rej" -type f)
if [ -n "$REJECTS" ]; then
    echo "⚠️ Conflict details in rejected files:"
    for rej in $REJECTS; do
        echo "=== Rejection in $rej ==="
        head -n 20 "$rej"
    done
fi

exit 1
