z#!/bin/bash

file=$1
true_dir=/data/tkz5115/repeat_project/data/dat/$file
predicted_dir=$true_dir/TH_results

# Compile the program
g++ -o evaluate_random evaluate_random.cpp -std=c++11

if [ $? -eq 0 ]; then
    echo "evaluate_random compilation successful."

    # Array of parameters
    params=(
        "$predicted_dir/th_5_2_my.fasta"
        "$predicted_dir/th_5_3_my.fasta"
        "$predicted_dir/th_5_4_my.fasta"
        "$predicted_dir/th_5_5_my.fasta"
        "$predicted_dir/th_5_10_my.fasta"
        "$predicted_dir/th_5_20_my.fasta"
        "$predicted_dir/th_5_50_my.fasta"
        "$predicted_dir/th_5_100_my.fasta"
        "$predicted_dir/th_5_200_my.fasta"

        "$predicted_dir/th_10_2_my.fasta"
        "$predicted_dir/th_10_3_my.fasta"
        "$predicted_dir/th_10_4_my.fasta"
        "$predicted_dir/th_10_5_my.fasta"
        "$predicted_dir/th_10_10_my.fasta"
        "$predicted_dir/th_10_20_my.fasta"
        "$predicted_dir/th_10_50_my.fasta"
        "$predicted_dir/th_10_100_my.fasta"
        "$predicted_dir/th_10_200_my.fasta"

        "$predicted_dir/th_20_2_my.fasta"
        "$predicted_dir/th_20_3_my.fasta"
        "$predicted_dir/th_20_4_my.fasta"
        "$predicted_dir/th_20_5_my.fasta"
        "$predicted_dir/th_20_10_my.fasta"
        "$predicted_dir/th_20_20_my.fasta"
        "$predicted_dir/th_20_50_my.fasta"
        "$predicted_dir/th_20_100_my.fasta"

        "$predicted_dir/th_50_2_my.fasta"
        "$predicted_dir/th_50_3_my.fasta"
        "$predicted_dir/th_50_4_my.fasta"
        "$predicted_dir/th_50_5_my.fasta"
        "$predicted_dir/th_50_10_my.fasta"
        "$predicted_dir/th_50_20_my.fasta"
        "$predicted_dir/th_50_50_my.fasta"
        "$predicted_dir/th_50_100_my.fasta"

        "$predicted_dir/th_100_2_my.fasta"
        "$predicted_dir/th_100_3_my.fasta"
        "$predicted_dir/th_100_4_my.fasta"
        "$predicted_dir/th_100_5_my.fasta"
        "$predicted_dir/th_100_10_my.fasta"
        "$predicted_dir/th_100_20_my.fasta"
        "$predicted_dir/th_100_30_my.fasta"

        "$predicted_dir/th_200_2_my.fasta"
        "$predicted_dir/th_200_3_my.fasta"
        "$predicted_dir/th_200_4_my.fasta"
        "$predicted_dir/th_200_5_my.fasta"
        "$predicted_dir/th_200_10_my.fasta"
        "$predicted_dir/th_200_20_my.fasta"
        )

    # Loop through each parameter
    for param in "${params[@]}"
    do
        # Extract the number part using sed
        number_part=$(basename "$param" | sed -E 's/(_[0-9]+)?\.[^.]+$//')

        output_file="$predicted_dir/eval_${number_part}.txt"

        echo $param
        echo $output_file

        ./evaluate_random $param $output_file
    done
else
    echo "Compilation failed."
fi
