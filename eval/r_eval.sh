#!/bin/bash

method=EquiRep
# Array of data_index values
data_indices=("error_10" "error_20")

# Compile the program
g++ -o evaluate_edit evaluate_edit.cpp -std=c++11

if [ $? -eq 0 ]; then
    echo "evaluate_edit compilation successful."

    # Loop through each data_index
    for data_index in "${data_indices[@]}"
    do
        true_dir=../data/simulated_data/dat3/$data_index
        # Replace dat3 with dat_aax2 or dat_aax3 to test on other simulated data
        predicted_dir=../$method\_test/$method\_$data_index

        # Array of parameters
        params=(
            "$true_dir/5_3_ans.fasta $predicted_dir/5_3_predicted.fasta"
            "$true_dir/5_5_ans.fasta $predicted_dir/5_5_predicted.fasta"
            "$true_dir/5_10_ans.fasta $predicted_dir/5_10_predicted.fasta"
            "$true_dir/5_20_ans.fasta $predicted_dir/5_20_predicted.fasta"
            # "$true_dir/5_50_ans.fasta $predicted_dir/5_50_predicted.fasta"

            "$true_dir/10_3_ans.fasta $predicted_dir/10_3_predicted.fasta"
            "$true_dir/10_5_ans.fasta $predicted_dir/10_5_predicted.fasta"
            "$true_dir/10_10_ans.fasta $predicted_dir/10_10_predicted.fasta"
            "$true_dir/10_20_ans.fasta $predicted_dir/10_20_predicted.fasta"
            # "$true_dir/10_50_ans.fasta $predicted_dir/10_50_predicted.fasta"

            "$true_dir/50_3_ans.fasta $predicted_dir/50_3_predicted.fasta"
            "$true_dir/50_5_ans.fasta $predicted_dir/50_5_predicted.fasta"
            "$true_dir/50_10_ans.fasta $predicted_dir/50_10_predicted.fasta"
            "$true_dir/50_20_ans.fasta $predicted_dir/50_20_predicted.fasta"
            # "$true_dir/50_50_ans.fasta $predicted_dir/50_50_predicted.fasta"

            "$true_dir/200_3_ans.fasta $predicted_dir/200_3_predicted.fasta"
            "$true_dir/200_5_ans.fasta $predicted_dir/200_5_predicted.fasta"
            "$true_dir/200_10_ans.fasta $predicted_dir/200_10_predicted.fasta"
            "$true_dir/200_20_ans.fasta $predicted_dir/200_20_predicted.fasta"
            # "$true_dir/200_50_ans.fasta $predicted_dir/200_50_predicted.fasta"

            "$true_dir/500_3_ans.fasta $predicted_dir/500_3_predicted.fasta"
            "$true_dir/500_5_ans.fasta $predicted_dir/500_5_predicted.fasta"
            "$true_dir/500_10_ans.fasta $predicted_dir/500_10_predicted.fasta"
            "$true_dir/500_20_ans.fasta $predicted_dir/500_20_predicted.fasta"
        )

        # Loop through each parameter
        for param in "${params[@]}"
        do
            # Extract the second parameter
            second_param=$(echo $param | awk '{print $2}')

            # Extract the number part using sed
            number_part=$(echo $second_param | sed -E 's|^.*/([0-9_]+)[^/]*$|\1|')

            output_file="$predicted_dir/eval_${number_part}.txt"

            echo $param
            echo $output_file
            # Run the program with the parameters
            ./evaluate_edit $param $output_file &
        done
    done
    wait
else
    echo "Compilation failed."
fi

