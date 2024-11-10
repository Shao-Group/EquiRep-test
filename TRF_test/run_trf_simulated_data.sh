#!/bin/bash

file=$1
dataset=dat3
# Replace dat3 with dat_aax2 or dat_aax3 to test on other simulated data
tool_dir=
# Put the location of your installed TRF here
input_dir=../data/simulated_data/$dataset/$file
output_dir=../data/simulated_data/$dataset/$file/TRF_results

mkdir -p $output_dir

# Array of parameters for generating trf output files
params=(
    "$input_dir/5_3_my.fasta"
    "$input_dir/5_5_my.fasta"
    "$input_dir/5_10_my.fasta"
    "$input_dir/5_20_my.fasta"
    # "$input_dir/5_50_my.fasta"

    "$input_dir/10_3_my.fasta"
    "$input_dir/10_5_my.fasta"
    "$input_dir/10_10_my.fasta"
    "$input_dir/10_20_my.fasta"
    # "$input_dir/10_50_my.fasta"

    "$input_dir/50_3_my.fasta"
    "$input_dir/50_5_my.fasta"
    "$input_dir/50_10_my.fasta"
    "$input_dir/50_20_my.fasta"
    # "$input_dir/50_50_my.fasta"

    "$input_dir/200_3_my.fasta"
    "$input_dir/200_5_my.fasta"
    "$input_dir/200_10_my.fasta"
    "$input_dir/200_20_my.fasta"
    # "$input_dir/200_50_my.fasta"

    "$input_dir/500_3_my.fasta"
    "$input_dir/500_5_my.fasta"
    "$input_dir/500_10_my.fasta"
    "$input_dir/500_20_my.fasta"
)

# Loop through each parameter
for param in "${params[@]}"
do
    # Extract the number part using sed
    number_part=$(echo $param | sed -E 's|^.*/([0-9_]+)[^/]*$|\1|')

    output_file="$output_dir/trf_${number_part}my.out"

    echo $param
    #echo $output_file
    $tool_dir/trf409.linux64 $param 2 7 7 80 10 50 500 -h -ngs > $output_file
done

# Compile the program
g++ -o trf_to_fasta trf_to_fasta.cpp -std=c++11

if [ $? -eq 0 ]; then
    echo "trf_to_fasta compilation successful."

    # Array of parameters for generating fasta files with trf sequence (highest count) from trf output
    params=(
        "$output_dir/trf_5_3_my.out"
        "$output_dir/trf_5_5_my.out"
        "$output_dir/trf_5_10_my.out"
        "$output_dir/trf_5_20_my.out"
        # "$output_dir/trf_5_50_my.out"

        "$output_dir/trf_10_3_my.out"
        "$output_dir/trf_10_5_my.out"
        "$output_dir/trf_10_10_my.out"
        "$output_dir/trf_10_20_my.out"
        # "$output_dir/trf_10_50_my.out"

        "$output_dir/trf_50_3_my.out"
        "$output_dir/trf_50_5_my.out"
        "$output_dir/trf_50_10_my.out"
        "$output_dir/trf_50_20_my.out"
        # "$output_dir/trf_50_50_my.out"
        
        "$output_dir/trf_200_3_my.out"
        "$output_dir/trf_200_5_my.out"
        "$output_dir/trf_200_10_my.out"
        "$output_dir/trf_200_20_my.out"
        # "$output_dir/trf_200_50_my.out"

        "$output_dir/trf_500_3_my.out"
        "$output_dir/trf_500_5_my.out"
        "$output_dir/trf_500_10_my.out"
        "$output_dir/trf_500_20_my.out"
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
        
        ./trf_to_fasta $param $output_file
    done
else
    echo "Compilation failed."
fi