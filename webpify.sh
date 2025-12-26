#!/usr/bin/env bash

# ------------------------------------------------------------
# webpifySH
#
# A lightweight Bash script for converting images to WebP
# using Googleâ€™s cwebp encoder.
#
# Supported formats:
#   jpg, jpeg, png, gif, bmp, tiff (case-insensitive)
#
# Usage:
#   ./webpify.sh [input_directory] [quality]
#
# Arguments:
#   input_directory  Directory containing images (default: .)
#   quality          WebP quality 0â€“100 (default: 80)
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

set -euo pipefail
IFS=$'\n\t'

INPUT_DIR="${1:-.}"
QUALITY="${2:-80}"
OUTPUT="$INPUT_DIR/converted"

command -v cwebp >/dev/null 2>&1 || {
  echo "âŒ Error: cwebp is not installed."
  echo "Install via: sudo apt install webp  |  brew install webp"
  exit 1
}

mkdir -p "$OUTPUT"

echo "í³‚ Input:   $INPUT_DIR"
echo "í³ Output:  $OUTPUT"
echo "í¾šï¸ Quality: $QUALITY"
echo ""

count=0

while IFS= read -r img; do
  filename="$(basename "$img")"
  name="${filename%.*}"

  if [[ -f "$OUTPUT/$name.webp" ]]; then
    echo "â­ï¸  Skipping $filename"
    continue
  fi

  cwebp "$img" -q "$QUALITY" -o "$OUTPUT/$name.webp" >/dev/null
  echo "âœ” $filename â†’ converted/$name.webp"
  ((count++))

done < <(
  find "$INPUT_DIR" -maxdepth 1 -type f \
    \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o -iname "*.bmp" -o -iname "*.tiff" \)
)

echo ""
echo "í¾‰ Done! Converted $count image(s)."
