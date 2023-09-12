#!/bin/bash

# Directory containing recovered files
RECOVERED_DIR="/path/to/recovered/files"

# Directory to store metadata files
METADATA_DIR="./metadata"

mkdir -p "$METADATA_DIR"

find "$RECOVERED_DIR" -type f | while read -r file; do
    # Generate a metadata file for each recovered file
    metadata_file="$METADATA_DIR/$(basename "$file").meta"
    exiftool -a -u -g1 "$file" > "$metadata_file"
done
