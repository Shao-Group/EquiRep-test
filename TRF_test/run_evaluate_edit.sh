#!/bin/bash

file=$1
true_dir=../data/simulated_data/dat3/$file
# Replace dat3 with dat_aax2 or dat_aax3 to test on other simulated data
predicted_dir=$true_dir/TRF_results

# Compile the program
g++ -o evaluate_edit evaluate_edit.cpp -std=c++11

if [ $? -eq 0 ]; then
    echo "evaluate_edit compilation successful."

    # Array of parameters
    params=(
        "$true_dir/5_3_ans.fasta $predicted_dir/trf_5_3_my.fasta"
        "$true_dir/5_5_ans.fasta $predicted_dir/trf_5_5_my.fasta"
        "$true_dir/5_10_ans.fasta $predicted_dir/trf_5_10_my.fasta"
        "$true_dir/5_20_ans.fasta $predicted_dir/trf_5_20_my.fasta"
        # "$true_dir/5_50_ans.fasta $predicted_dir/trf_5_50_my.fasta"

        "$true_dir/10_3_ans.fasta $predicted_dir/trf_10_3_my.fasta"
        "$true_dir/10_5_ans.fasta $predicted_dir/trf_10_5_my.fasta"
        "$true_dir/10_10_ans.fasta $predicted_dir/trf_10_10_my.fasta"
        "$true_dir/10_20_ans.fasta $predicted_dir/trf_10_20_my.fasta"
        # "$true_dir/10_50_ans.fasta $predicted_dir/trf_10_50_my.fasta"

        "$true_dir/50_3_ans.fasta $predicted_dir/trf_50_3_my.fasta"
        "$true_dir/50_5_ans.fasta $predicted_dir/trf_50_5_my.fasta"
        "$true_dir/50_10_ans.fasta $predicted_dir/trf_50_10_my.fasta"
        "$true_dir/50_20_ans.fasta $predicted_dir/trf_50_20_my.fasta"
        # "$true_dir/50_50_ans.fasta $predicted_dir/trf_50_50_my.fasta"

        "$true_dir/200_3_ans.fasta $predicted_dir/trf_200_3_my.fasta"
        "$true_dir/200_5_ans.fasta $predicted_dir/trf_200_5_my.fasta"
        "$true_dir/200_10_ans.fasta $predicted_dir/trf_200_10_my.fasta"
        "$true_dir/200_20_ans.fasta $predicted_dir/trf_200_20_my.fasta"
        # "$true_dir/200_50_ans.fasta $predicted_dir/trf_200_50_my.fasta"

        "$true_dir/500_3_ans.fasta $predicted_dir/trf_500_3_my.fasta"
        "$true_dir/500_5_ans.fasta $predicted_dir/trf_500_5_my.fasta"
        "$true_dir/500_10_ans.fasta $predicted_dir/trf_500_10_my.fasta"
        "$true_dir/500_20_ans.fasta $predicted_dir/trf_500_20_my.fasta"

        )

    # Loop through each parameter
    for param in "${params[@]}"
    do
        # Extract the second parameter
        second_param=$(echo $param | awk '{print $2}')

        # Extract the number part using sed
        number_part=$(basename "$second_param" | sed -E 's/(_[0-9]+)?\.[^.]+$//')

        output_file="$predicted_dir/eval_${number_part}.txt"

        echo $param
        echo $output_file

        ./evaluate_edit $param $output_file
    done
else
    echo "Compilation failed."
fi
