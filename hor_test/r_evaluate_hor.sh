#!/bin/bash

true_file="/datadisk1/zps5227/rf1/hor_test/HOR_data/hors_seqs.fasta"
predicted_file=/datadisk1/zps5227/rf1/hor_test/trd23_HOR_data/hor_combined.fasta

# Compile the program
g++ -o evaluate_hor evaluate_hor.cpp -std=c++11

if [ $? -eq 0 ]; then
    echo "evaluate_hor compilation successful."

    output_file=/datadisk1/zps5227/rf1/hor_test/trd23_HOR_data/eval_hor_combined_predicted.fasta
    echo $output_file
    ./evaluate_hor $true_file $predicted_file $output_file
else
    echo "Compilation failed."
fi
