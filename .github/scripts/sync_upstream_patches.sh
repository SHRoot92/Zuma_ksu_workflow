#!/usr/bin/env bash
# sync_upstream_patches.sh - Auto-download and sync latest patches from midori01 for Cheetah (6.1)

set -e

MIDORI_RAW="https://raw.githubusercontent.com/midori01/gki_ksu_workflow/main/.github/patches"
PATCHES_DIR=".github/patches"

echo "📥 Syncing upstream patches from midori01 for 6.1 (GKI & Sultan)..."
mkdir -p "${PATCHES_DIR}/xxksu"

download_patch() {
    local remote_url="$1"
    local local_file="$2"
    echo "  -> Downloading $(basename "$local_file")..."
    curl -s -f -L --max-time 15 "$remote_url" -o "${local_file}.tmp"
    if [ -s "${local_file}.tmp" ]; then
        mv "${local_file}.tmp" "$local_file"
        echo "     ✅ Updated $local_file"
    else
        rm -f "${local_file}.tmp"
        echo "     ⚠️ Skipping empty or unavailable: $remote_url"
    fi
}

# 1. Root KSU SuSFS patch
download_patch "${MIDORI_RAW}/11_enable_susfs_for_ksu.patch" "${PATCHES_DIR}/xxksu/11_enable_susfs_for_ksu.patch"

# 2. Android 14 6.1 GKI & Sultan patches
download_patch "${MIDORI_RAW}/android14-6.1/51_deinlined_susfs_hooks_gki-android14-6.1.patch" "${PATCHES_DIR}/xxksu/51_deinlined_susfs_hooks_gki-android14-6.1.patch"
download_patch "${MIDORI_RAW}/android14-6.1/51_deinlined_susfs_hooks_sultan-android14-6.1.patch" "${PATCHES_DIR}/xxksu/51_deinlined_susfs_hooks_sultan-android14-6.1.patch"
download_patch "${MIDORI_RAW}/android14-6.1/50_add_susfs_in_gki-android14-6.1.patch" "${PATCHES_DIR}/xxksu/50_add_susfs_in_gki-android14-6.1.patch"
download_patch "${MIDORI_RAW}/android14-6.1/scope-min-manual-hooks-v2.3.patch" "${PATCHES_DIR}/scope-min-manual-hooks-v2.3.patch"
download_patch "${MIDORI_RAW}/android14-6.1/scope-min-manual-hooks-v2.2.patch" "${PATCHES_DIR}/scope-min-manual-hooks-v2.2.patch"

echo "✨ Cheetah 6.1 patches sync complete!"
