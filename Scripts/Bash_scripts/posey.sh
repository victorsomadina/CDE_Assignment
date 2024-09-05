#!/bin/bash

# Verify PostgreSQL version
psql --version

# Set PostgreSQL password
export PGPASSWORD="***********"

# create database
psql -U postgres -h localhost -p 5432 -c "CREATE DATABASE posey;"

# List the tables you have in the database
echo "Listing tables in the 'posey' database:"
psql -U postgres -d posey -c "\dt"

# Define schemas
echo "Creating schemas..."
psql -U postgres -d posey -c "CREATE TABLE IF NOT EXISTS accounts (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    website VARCHAR(255),
    lat FLOAT8,
    long FLOAT8,
    primary_poc VARCHAR(255),
    sales_rep_id INT
)"
psql -U postgres -d posey -c "CREATE TABLE IF NOT EXISTS orders (
    id INT PRIMARY KEY,
    account_id INT,
    occurred_at TIMESTAMP,
    standard_qty INT,
    gloss_qty INT,
    poster_qty INT,
    total INT,
    standard_amt_usd FLOAT8,
    gloss_amt_usd FLOAT8,
    poster_amt_usd FLOAT8,
    total_amt_usd FLOAT8
)"
psql -U postgres -d posey -c "CREATE TABLE IF NOT EXISTS region (
    id INT PRIMARY KEY,
    name VARCHAR(255)
)"
psql -U postgres -d posey -c "CREATE TABLE IF NOT EXISTS sales_reps (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    region_id INT
)"
psql -U postgres -d posey -c "CREATE TABLE IF NOT EXISTS web_events (
    id INT,
    account_id INT,
    occurred_at TIMESTAMP,
    channel VARCHAR(255)
)"

echo "Schema creation completed"

# Unzip downloaded zip file into a new folder
echo "Unzipping the file..."
cd /c/Users/hp/Downloads
mkdir -p "parch_posey_unzipped"
unzip -q "wetransfer_parch_posey_data_2024-08-28_2103.zip" -d "parch_posey_unzipped"

# List the contents of the unzipped folder
echo "Contents of the unzipped folder:"
ls "parch_posey_unzipped"

# Define environmental variables
CSV_DIR="C:\Users\hp\Downloads\parch_posey_unzipped"
DB_USER="postgres"
DB_NAME="posey"

# Move files to PostgreSQL database
echo "Importing CSV files into PostgreSQL..."
for csv_file in "$CSV_DIR"/*.csv; do table_name=$(basename "$csv_file" .csv); psql -U "$DB_USER" -d "$DB_NAME" -c "\COPY $table_name FROM "$csv_file" WITH (FORMAT csv, HEADER true)"; done

echo "File transfer completed"
echo "Database Created"


