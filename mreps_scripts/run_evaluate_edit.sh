#!/bin/bash

file=$1
true_dir=/data/tkz5115/repeat_project/data/dat3/$file
predicted_dir=$true_dir/mreps_results

# Compile the program
g++ -o evaluate_edit evaluate_edit.cpp -std=c++11

if [ $? -eq 0 ]; then
    echo "evaluate_edit compilation successful."

    # Array of parameters
    params=(
        "$true_dir/5_2_ans.fasta $predicted_dir/mreps_5_2_my.fasta"
        "$true_dir/5_3_ans.fasta $predicted_dir/mreps_5_3_my.fasta"
        "$true_dir/5_4_ans.fasta $predicted_dir/mreps_5_4_my.fasta"
        "$true_dir/5_5_ans.fasta $predicted_dir/mreps_5_5_my.fasta"
        "$true_dir/5_10_ans.fasta $predicted_dir/mreps_5_10_my.fasta"
        "$true_dir/5_20_ans.fasta $predicted_dir/mreps_5_20_my.fasta"
        "$true_dir/5_50_ans.fasta $predicted_dir/mreps_5_50_my.fasta"
        "$true_dir/5_100_ans.fasta $predicted_dir/mreps_5_100_my.fasta"
        "$true_dir/5_200_ans.fasta $predicted_dir/mreps_5_200_my.fasta"

        "$true_dir/10_2_ans.fasta $predicted_dir/mreps_10_2_my.fasta"
        "$true_dir/10_3_ans.fasta $predicted_dir/mreps_10_3_my.fasta"
        "$true_dir/10_4_ans.fasta $predicted_dir/mreps_10_4_my.fasta"
        "$true_dir/10_5_ans.fasta $predicted_dir/mreps_10_5_my.fasta"
        "$true_dir/10_10_ans.fasta $predicted_dir/mreps_10_10_my.fasta"
        "$true_dir/10_20_ans.fasta $predicted_dir/mreps_10_20_my.fasta"
        "$true_dir/10_50_ans.fasta $predicted_dir/mreps_10_50_my.fasta"
        "$true_dir/10_100_ans.fasta $predicted_dir/mreps_10_100_my.fasta"
        "$true_dir/10_200_ans.fasta $predicted_dir/mreps_10_200_my.fasta"

        "$true_dir/20_2_ans.fasta $predicted_dir/mreps_20_2_my.fasta"
        "$true_dir/20_3_ans.fasta $predicted_dir/mreps_20_3_my.fasta"
        "$true_dir/20_4_ans.fasta $predicted_dir/mreps_20_4_my.fasta"
        "$true_dir/20_5_ans.fasta $predicted_dir/mreps_20_5_my.fasta"
        "$true_dir/20_10_ans.fasta $predicted_dir/mreps_20_10_my.fasta"
        "$true_dir/20_20_ans.fasta $predicted_dir/mreps_20_20_my.fasta"
        "$true_dir/20_50_ans.fasta $predicted_dir/mreps_20_50_my.fasta"
        "$true_dir/20_100_ans.fasta $predicted_dir/mreps_20_100_my.fasta"

        "$true_dir/50_2_ans.fasta $predicted_dir/mreps_50_2_my.fasta"
        "$true_dir/50_3_ans.fasta $predicted_dir/mreps_50_3_my.fasta"
        "$true_dir/50_4_ans.fasta $predicted_dir/mreps_50_4_my.fasta"
        "$true_dir/50_5_ans.fasta $predicted_dir/mreps_50_5_my.fasta"
        "$true_dir/50_10_ans.fasta $predicted_dir/mreps_50_10_my.fasta"
        "$true_dir/50_20_ans.fasta $predicted_dir/mreps_50_20_my.fasta"
        "$true_dir/50_50_ans.fasta $predicted_dir/mreps_50_50_my.fasta"
        "$true_dir/50_100_ans.fasta $predicted_dir/mreps_50_100_my.fasta"

        "$true_dir/100_2_ans.fasta $predicted_dir/mreps_100_2_my.fasta"
        "$true_dir/100_3_ans.fasta $predicted_dir/mreps_100_3_my.fasta"
        "$true_dir/100_4_ans.fasta $predicted_dir/mreps_100_4_my.fasta"
        "$true_dir/100_5_ans.fasta $predicted_dir/mreps_100_5_my.fasta"
        "$true_dir/100_10_ans.fasta $predicted_dir/mreps_100_10_my.fasta"
        "$true_dir/100_20_ans.fasta $predicted_dir/mreps_100_20_my.fasta"
        "$true_dir/100_30_ans.fasta $predicted_dir/mreps_100_30_my.fasta"

        "$true_dir/200_2_ans.fasta $predicted_dir/mreps_200_2_my.fasta"
        "$true_dir/200_3_ans.fasta $predicted_dir/mreps_200_3_my.fasta"
        "$true_dir/200_4_ans.fasta $predicted_dir/mreps_200_4_my.fasta"
        "$true_dir/200_5_ans.fasta $predicted_dir/mreps_200_5_my.fasta"
        "$true_dir/200_10_ans.fasta $predicted_dir/mreps_200_10_my.fasta"
        "$true_dir/200_20_ans.fasta $predicted_dir/mreps_200_20_my.fasta"
        "$true_dir/200_50_ans.fasta $predicted_dir/mreps_200_50_my.fasta"

        "$true_dir/500_2_ans.fasta $predicted_dir/mreps_500_2_my.fasta"
        "$true_dir/500_3_ans.fasta $predicted_dir/mreps_500_3_my.fasta"
        "$true_dir/500_4_ans.fasta $predicted_dir/mreps_500_4_my.fasta"
        "$true_dir/500_5_ans.fasta $predicted_dir/mreps_500_5_my.fasta"
        "$true_dir/500_10_ans.fasta $predicted_dir/mreps_500_10_my.fasta"
        "$true_dir/500_20_ans.fasta $predicted_dir/mreps_500_20_my.fasta"
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
