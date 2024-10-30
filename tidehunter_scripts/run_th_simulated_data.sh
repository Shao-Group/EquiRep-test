#!/bin/bash

file=$1
tool_dir=/data/tkz5115/repeat_project/tools/TideHunter-v1.5.5/bin
input_dir=/data/tkz5115/repeat_project/data/dat3/$file
output_dir=/data/tkz5115/repeat_project/data/dat3/$file/TH_results

mkdir -p $output_dir

# Array of parameters for generating th output files
params=(
    "$input_dir/5_2_my.fasta"
    "$input_dir/5_3_my.fasta"
    "$input_dir/5_4_my.fasta"
    "$input_dir/5_5_my.fasta"
    "$input_dir/5_10_my.fasta"
    "$input_dir/5_20_my.fasta"
    "$input_dir/5_50_my.fasta"
    "$input_dir/5_100_my.fasta"
    "$input_dir/5_200_my.fasta"

    "$input_dir/10_2_my.fasta"
    "$input_dir/10_3_my.fasta"
    "$input_dir/10_4_my.fasta"
    "$input_dir/10_5_my.fasta"
    "$input_dir/10_10_my.fasta"
    "$input_dir/10_20_my.fasta"
    "$input_dir/10_50_my.fasta"
    "$input_dir/10_100_my.fasta"
    "$input_dir/10_200_my.fasta"

    "$input_dir/20_2_my.fasta"
    "$input_dir/20_3_my.fasta"
    "$input_dir/20_4_my.fasta"
    "$input_dir/20_5_my.fasta"
    "$input_dir/20_10_my.fasta"
    "$input_dir/20_20_my.fasta"
    "$input_dir/20_50_my.fasta"
    "$input_dir/20_100_my.fasta"

    "$input_dir/50_2_my.fasta"
    "$input_dir/50_3_my.fasta"
    "$input_dir/50_4_my.fasta"
    "$input_dir/50_5_my.fasta"
    "$input_dir/50_10_my.fasta"
    "$input_dir/50_20_my.fasta"
    "$input_dir/50_50_my.fasta"
    "$input_dir/50_100_my.fasta"

    "$input_dir/100_2_my.fasta"
    "$input_dir/100_3_my.fasta"
    "$input_dir/100_4_my.fasta"
    "$input_dir/100_5_my.fasta"
    "$input_dir/100_10_my.fasta"
    "$input_dir/100_20_my.fasta"
    "$input_dir/100_30_my.fasta"

    "$input_dir/200_2_my.fasta"
    "$input_dir/200_3_my.fasta"
    "$input_dir/200_4_my.fasta"
    "$input_dir/200_5_my.fasta"
    "$input_dir/200_10_my.fasta"
    "$input_dir/200_20_my.fasta"
    "$input_dir/200_50_my.fasta"

    "$input_dir/500_2_my.fasta"
    "$input_dir/500_3_my.fasta"
    "$input_dir/500_4_my.fasta"
    "$input_dir/500_5_my.fasta"
    "$input_dir/500_10_my.fasta"
    "$input_dir/500_20_my.fasta"
)

# Loop through each parameter
for param in "${params[@]}"
do
    # Extract the number part using sed
    number_part=$(echo $param | sed -E 's|^.*/([0-9_]+)[^/]*$|\1|')

    output_file="$output_dir/th_${number_part}my.out"

    echo $param
    #echo $output_file
    $tool_dir/TideHunter -f 2 $param > $output_file
done

# Compile the program
g++ -o th_to_fasta th_to_fasta.cpp -std=c++11

if [ $? -eq 0 ]; then
    echo "th_to_fasta compilation successful."

    # Array of parameters for generating fasta files with th sequence (highest count) from th output
    params=(
        "$output_dir/th_5_2_my.out"
        "$output_dir/th_5_3_my.out"
        "$output_dir/th_5_4_my.out"
        "$output_dir/th_5_5_my.out"
        "$output_dir/th_5_10_my.out"
        "$output_dir/th_5_20_my.out"
        "$output_dir/th_5_50_my.out"
        "$output_dir/th_5_100_my.out"
        "$output_dir/th_5_200_my.out"

        "$output_dir/th_10_2_my.out"
        "$output_dir/th_10_3_my.out"
        "$output_dir/th_10_4_my.out"
        "$output_dir/th_10_5_my.out"
        "$output_dir/th_10_10_my.out"
        "$output_dir/th_10_20_my.out"
        "$output_dir/th_10_50_my.out"
        "$output_dir/th_10_100_my.out"
        "$output_dir/th_10_200_my.out"

        "$output_dir/th_20_2_my.out"
        "$output_dir/th_20_3_my.out"
        "$output_dir/th_20_4_my.out"
        "$output_dir/th_20_5_my.out"
        "$output_dir/th_20_10_my.out"
        "$output_dir/th_20_20_my.out"
        "$output_dir/th_20_50_my.out"
        "$output_dir/th_20_100_my.out"

        "$output_dir/th_50_2_my.out"
        "$output_dir/th_50_3_my.out"
        "$output_dir/th_50_4_my.out"
        "$output_dir/th_50_5_my.out"
        "$output_dir/th_50_10_my.out"
        "$output_dir/th_50_20_my.out"
        "$output_dir/th_50_50_my.out"
        "$output_dir/th_50_100_my.out"
        
        "$output_dir/th_100_2_my.out"
        "$output_dir/th_100_3_my.out"
        "$output_dir/th_100_4_my.out"
        "$output_dir/th_100_5_my.out"
        "$output_dir/th_100_10_my.out"
        "$output_dir/th_100_20_my.out"
        "$output_dir/th_100_30_my.out"

        "$output_dir/th_200_2_my.out"
        "$output_dir/th_200_3_my.out"
        "$output_dir/th_200_4_my.out"
        "$output_dir/th_200_5_my.out"
        "$output_dir/th_200_10_my.out"
        "$output_dir/th_200_20_my.out"
        "$output_dir/th_200_50_my.out"

        "$output_dir/th_500_2_my.out"
        "$output_dir/th_500_3_my.out"
        "$output_dir/th_500_4_my.out"
        "$output_dir/th_500_5_my.out"
        "$output_dir/th_500_10_my.out"
        "$output_dir/th_500_20_my.out"
        )

    # Loop through each parameter
    for param in "${params[@]}"
    do
        # Extract the filename without extension
        file_name="${param%.*}"
        echo $file_name

        output_file="${file_name}.fasta"

        echo $param
        echo $output_file
        
        ./th_to_fasta $param $output_file
    done
else
    echo "Compilation failed."
fi