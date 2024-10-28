#!/bin/bash

input_file=./HOR_data/prostate_chosen_dotplot_reads.fasta                # The input file to compare with each file in the folder
comparison_folder=./hor_results         # Folder containing multiple comparison files
output_directory=./hor_cmp          # Directory to store output files

# Ensure output directory exists
mkdir -p "$output_directory"
g++ -O3 -o prostate_eval prostate_eval.cpp

# Loop through each file in the comparison folder
for comparison_file in "$comparison_folder"/*; do
    # Extract the base name of the comparison file
    base_name=$(basename "$comparison_file" .fasta)
    
    # Define the output file path
    output_file="${output_directory}/${base_name}_result.txt"
    
    echo "./prostate_eval "$input_file" "$comparison_file" "$output_file""
    # Run the alignment program and save the result to the output file
    ./prostate_eval "$input_file" "$comparison_file" "$output_file"
    
    echo "Processed $comparison_file -> $output_file"
done
