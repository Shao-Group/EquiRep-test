#!/bin/bash

file=$1
dataset=dat3
# Replace dat3 with dat_aax2 or dat_aax3 to test on other simulated data
tool_dir=
# Put the location of your installed mTR here
input_dir=../data/simulated_data/$dataset/$file
output_dir=../data/simulated_data/$dataset/$file/mreps_results

mkdir -p $output_dir

# Array of parameters for generating mreps output files
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

    output_file="$output_dir/mreps_${number_part}my.out"

    # Extract the first number after the last slash
    first_number=$(echo $param | sed -E 's|^.*/([0-9]+).*|\1|')

    # Determine res value based on first_number ranges (inclusive of the last value)
    if [ "$first_number" -le 15 ]; then
        resln=5
    elif [ "$first_number" -ge 16 ] && [ "$first_number" -le 20 ]; then
        resln=10
    elif [ "$first_number" -ge 21 ] && [ "$first_number" -le 50 ]; then
        resln=15
    elif [ "$first_number" -ge 51 ] && [ "$first_number" -le 100 ]; then
        resln=20
    elif [ "$first_number" -ge 101 ] && [ "$first_number" -le 200 ]; then
        resln=25
    else
        resln=30
    fi

    # # Determine res value based on first_number ranges (inclusive of the last value)
    # if [ "$first_number" -le 15 ]; then
    #     resln=5
    # elif [ "$first_number" -ge 16 ] && [ "$first_number" -le 20 ]; then
    #     resln=15
    # elif [ "$first_number" -ge 21 ] && [ "$first_number" -le 50 ]; then
    #     resln=25
    # elif [ "$first_number" -ge 51 ] && [ "$first_number" -le 100 ]; then
    #     resln=35
    # elif [ "$first_number" -ge 101 ] && [ "$first_number" -le 200 ]; then
    #     resln=45
    # else
    #     resln=50
    # fi

    echo $param
    echo $resln
    #echo $output_file
    $tool_dir/mreps -res $resln -fasta $param > $output_file
done

# Compile the program
g++ -o mreps_to_fasta mreps_to_fasta.cpp -std=c++11

if [ $? -eq 0 ]; then
    echo "mreps_to_fasta compilation successful."

    # Array of parameters for generating fasta files with mreps sequence (highest exp) from mreps output
    params=(
        "$output_dir/mreps_5_3_my.out"
        "$output_dir/mreps_5_5_my.out"
        "$output_dir/mreps_5_10_my.out"
        "$output_dir/mreps_5_20_my.out"
        # "$output_dir/mreps_5_50_my.out"

        "$output_dir/mreps_10_3_my.out"
        "$output_dir/mreps_10_5_my.out"
        "$output_dir/mreps_10_10_my.out"
        "$output_dir/mreps_10_20_my.out"
        # "$output_dir/mreps_10_50_my.out"

        "$output_dir/mreps_50_3_my.out"
        "$output_dir/mreps_50_5_my.out"
        "$output_dir/mreps_50_10_my.out"
        "$output_dir/mreps_50_20_my.out"
        # "$output_dir/mreps_50_50_my.out"

        "$output_dir/mreps_200_3_my.out"
        "$output_dir/mreps_200_5_my.out"
        "$output_dir/mreps_200_10_my.out"
        "$output_dir/mreps_200_20_my.out"
        # "$output_dir/mreps_200_50_my.out"

        "$output_dir/mreps_500_3_my.out"
        "$output_dir/mreps_500_5_my.out"
        "$output_dir/mreps_500_10_my.out"
        "$output_dir/mreps_500_20_my.out"
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
        
        ./mreps_to_fasta $param $output_file
    done
else
    echo "Compilation failed."
fi