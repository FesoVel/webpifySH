#!/usr/bin/env bash

# ------------------------------------------------------------
# webpifySH
#
# A lightweight Bash script for converting images to WebP
# using Google’s cwebp encoder.
#
# Supported formats:
#   jpg, jpeg, png, gif, bmp, tiff (case-insensitive)
#
# Usage:
#   ./webpify.sh [input_directory] [quality]
#
# Arguments:
#   input_directory  Directory containing images (default: .)
#   quality          WebP quality 0–100 (default: 80)
#
# Output:
#   Converted images are saved to:
#     input_directory/converted/
#
# Requirements:
#   cwebp (https://developers.google.com/speed/webp)
#
# License:
#   MIT
# ------------------------------------------------------------

# Input directory (default current folder)
INPUT_DIR="${1:-.}"

# Output directory inside the current folder
OUTPUT="$INPUT_DIR/converted"

# Make sure the directory exists
mkdir -p "$OUTPUT"

# Supported extensions
EXTENSIONS="jpg jpeg png gif bmp tiff JPG JPEG PNG GIF BMP TIFF"

echo "Converting images from: $INPUT_DIR"
echo "Saving to: $OUTPUT"
echo ""

count=0

for ext in $EXTENSIONS; do
    for img in "$INPUT_DIR"/*.$ext; do
        [ -e "$img" ] || continue

        filename=$(basename "$img")
        name="${filename%.*}"

        # Skip if already converted
        if [[ -f "$OUTPUT/$name.webp" ]]; then
            echo "Skipping $filename (already converted)"
            continue
        fi

        cwebp "$img" -q 80 -o "$OUTPUT/$name.webp"
        echo "$filename → converted/$name.webp"
        ((count++))
    done
done

echo ""
echo "Done! Converted $count new image(s)."
