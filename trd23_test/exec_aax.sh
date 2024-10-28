#!/bin/bash

code=trd23
input_dir_prefix=../data/dat_aax3

data_dirs=(full_10 full_20)

MAX_JOBS=60

# Compile the program
g++ -O3 -o $code $code.cpp -std=c++11

# Check if the compilation was successful
if [ $? -eq 0 ]; then
    echo "$code compilation successful."
    # Array of parameters
    params=(
        # "5_3_my.fasta 5_3_predicted."
        # "5_5_my.fasta 5_5_predicted."
        # "5_10_my.fasta 5_10_predicted."
        # "5_20_my.fasta 5_20_predicted."
        # # "5_50_my.fasta 5_50_predicted."

        # "10_3_my.fasta 10_3_predicted."
        # "10_5_my.fasta 10_5_predicted."
        # "10_10_my.fasta 10_10_predicted."
        # "10_20_my.fasta 10_20_predicted."
        # # "10_50_my.fasta 10_50_predicted."

        "50_3_my.fasta 50_3_predicted."
        "50_5_my.fasta 50_5_predicted."
        "50_10_my.fasta 50_10_predicted."
        "50_20_my.fasta 50_20_predicted."
        # "50_50_my.fasta 50_50_predicted."

        "200_3_my.fasta 200_3_predicted."
        "200_5_my.fasta 200_5_predicted."
        "200_10_my.fasta 200_10_predicted."
        "200_20_my.fasta 200_20_predicted."
        # "200_50_my.fasta 200_50_predicted."

        "500_3_my.fasta 500_3_predicted."
        "500_5_my.fasta 500_5_predicted."
        "500_10_my.fasta 500_10_predicted."
        "500_20_my.fasta 500_20_predicted."
    )

    # Loop through each input directory
    for data_dir in "${data_dirs[@]}"
    do
        output_dir=$code\_$data_dir
        input_dir="$input_dir_prefix/$data_dir"
        rm -r $output_dir
        mkdir -p $output_dir

        # Loop through each parameter
        for param in "${params[@]}"
        do
            input_file=$(echo $param | awk '{print $1}')
            output_file=$(echo $param | awk '{print $2}')
            echo "./$code $input_dir/$input_file $output_dir/$output_file"
            ./$code "$input_dir/$input_file" "$output_dir/$output_file" &
            while [ $(jobs -r | wc -l) -ge $MAX_JOBS ]; do
                wait -n
            done
        done
    done
    wait
else
    echo "Compilation failed."
fi
