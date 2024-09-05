#!/bin/bash

# create a Json_and_csv folder in the root directory
mkdir -p Json_and_csv 
echo "Json_and_csv folder has been created"

# Declare source and target folder variable
export source_dir="/c/Users/hp/Downloads"
export target_dir="/c/Users/hp/Json_and_csv"
echo "source and target directory environment variable declared"

# find and count csv and json files from the source directory
count=$(find "$source_dir" \( -name "*.json" -o -name "*.csv" \) | wc -l)
echo "Number of files found: $count"

# find and move files to Json_and_csv Folder
find "$source_dir" -maxdepth 1 \( -name "*.json" -o -name "*.csv" \) -exec mv {} "$target_dir" \;
echo "files has been moved to Json and Csv folder"
echo "files executed successfully" 
