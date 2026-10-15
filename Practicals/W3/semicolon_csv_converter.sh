#!/bin/bash

input_file="$1"

if [ -z "$input_file" ]; then
    echo "Usage: bash semicolon_csv_converter.sh filename.csv"
    exit 1
fi

if [ ! -f "$input_file" ]; then
    echo "Error: File not found: $input_file"
    exit 1
fi

output_file="${input_file%.*}_converted.csv"

tr ';' ',' < "$input_file" > "$output_file"

echo "Converted file saved as: $output_file"
