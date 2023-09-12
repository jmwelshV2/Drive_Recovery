#!/bin/bash

# Directories containing recovered files
RECOVERY_DIRS=("/mnt/recovery1" "/mnt/recovery2")

# Directory to store metadata files
METADATA_DIR="./metadata"

mkdir -p "$METADATA_DIR"

for RECOVERY_DIR in "${RECOVERY_DIRS[@]}"; do
  if [[ -d "$RECOVERY_DIR" ]]; then
    find "$RECOVERY_DIR" -type f | while read -r file; do
      # Generate a metadata file for each recovered file
      metadata_file="$METADATA_DIR/$(basename "$file").meta"
      exiftool -a -u -g1 "$file" > "$metadata_file"
    done
  else
    echo "Directory $RECOVERY_DIR does not exist"
  fi
done
