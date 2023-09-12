#!/bin/bash

# Directories containing recovered files
RECOVERY_DIRS=("/mnt/recovery1" "/mnt/recovery2")

# Directory containing metadata files
METADATA_DIR="./metadata"

# Directory to store organized files
ORGANIZED_DIR="./organized_files"

mkdir -p "$ORGANIZED_DIR"

find "$METADATA_DIR" -type f | while read -r meta_file; do
  # Logic to read metadata and move files based on criteria
  # This is a simple demonstration where it reads creation date to organize files.
  
  original_file=""
  for RECOVERY_DIR in "${RECOVERY_DIRS[@]}"; do
    possible_file="$RECOVERY_DIR/$(basename "$meta_file" .meta)"
    if [[ -f "$possible_file" ]]; then
      original_file="$possible_file"
      break
    fi
  done

  if [[ -z "$original_file" ]]; then
    echo "Original file for $meta_file not found"
    continue
  fi

  creation_date=$(grep "Create Date" "$meta_file" | awk -F': ' '{print $2}')

  if [[ ! -z "$creation_date" ]]; then
    # Creating a directory based on creation date
    target_dir="$ORGANIZED_DIR/$(date -d "$creation_date" +'%Y-%m-%d')"
    mkdir -p "$target_dir"
    
    # Moving the file to the target directory
    mv "$original_file" "$target_dir/"
  fi
done
