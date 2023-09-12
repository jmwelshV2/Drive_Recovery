#!/bin/bash

# Directories containing recovered files
RECOVERY_DIRS=("/mnt/recovery1" "/mnt/recovery2")

# Directory to store metadata files
METADATA_DIR="./metadata"

mkdir -p "$METADATA_DIR"

for RECOVERY_DIR in "${RECOVERY_DIRS[@]}"; do
  if [[ -d "$RECOVERY_DIR" ]]; then
    # Find potential metadata files such as NTFS MFT files, and others that might hold organizational data
    find "$RECOVERY_DIR" -type f \( -iname '*MFT*' -o -iname '*$LogFile*' -o -iname '*$Volume*' -o -iname '*$AttrDef*' -o -iname '*$Bitmap*' -o -iname '*$Boot*' \) | while read -r file; do
      # Copy potential metadata files to the metadata directory for further inspection
      cp "$file" "$METADATA_DIR/"
    done
  else
    echo "Directory $RECOVERY_DIR does not exist"
  fi
done

echo "Metadata extraction completed. Please check $METADATA_DIR for the extracted metadata files."
