#!/bin/bash

# This script is used to perform a simple ETL process. The raw folder houses the raw dataset loaded from the URL provided.
# The transformed folder and the gold directory store the transformed data file.

# Define the environment variable for the URL
export URL="https://www.stats.govt.nz/assets/Uploads/Annual-enterprise-survey/Annual-enterprise-survey-2023-financial-year-provisional/Download-data/annual-enterprise-survey-2023-financial-year-provisional.csv"

# Print the content of the URL variable
echo "Downloading data from URL: $URL"

# Create the parent folder etl_assignment if it doesn't exist
mkdir -p etl_assignment
cd etl_assignment || { echo "Failed to enter etl_assignment directory"; exit 1; }

# Create raw folder and navigate to it
mkdir -p raw
cd raw || { echo "Failed to enter raw directory"; exit 1; }

# Download the data from the URL
curl -o data.csv "$URL"

# Confirm data is in the raw folder
echo "Data file in raw folder:"
ls -l data.csv
echo "Data is in the raw folder"

# Transform - Change Variable_code to variable_code
echo "Transforming data: Changing 'Variable_code' to 'variable_code'"
head -n 1 data.csv # Print the header to confirm column names
sed -i 's/Variable_code/variable_code/g' data.csv # Change Variable_code to variable_code

# Extract the required 4 columns
echo "Extracting columns 1, 9, 5, 6 into 2023_year_finance.csv"
cut -d',' -f1,9,5,6 data.csv > 2023_year_finance.csv

# Move data into the transformed folder
cd .. || { echo "Failed to go to etl_assignment directory"; exit 1; }
mkdir -p transformed  # Create transformed directory if it doesn't exist

# Move transformed file to transformed folder
mv raw/2023_year_finance.csv transformed/

# Confirm the file has been moved
echo "Files in transformed folder:"
ls -l transformed/

# Make the gold directory
mkdir -p gold

# Copy data to gold directory
cp transformed/2023_year_finance.csv gold/

# Confirm the file has been copied
echo "Files in gold folder:"
ls -l gold/

echo "ETL process completed successfully."
