#!/bin/bash

code=trd23
input_dir_prefix=.

data_dirs=(HOR_data)

MAX_JOBS=60

# Compile the program
g++ -O3 -o $code $code.cpp -std=c++11 -mcmodel=medium
# g++ -O3 -o trd24 trd24.cpp -std=c++11 -mcmodel=medium


# Check if the compilation was successful
if [ $? -eq 0 ]; then
    echo "$code compilation successful."
    # Array of parameters
    params=(
        # "prostate_1.fasta prostate_1_predicted."
        # "prostate_2.fasta prostate_2_predicted."
        # "prostate_3.fasta prostate_3_predicted."
        # "prostate_4.fasta prostate_4_predicted."
        # "prostate_5.fasta prostate_5_predicted."
        # "prostate_6.fasta prostate_6_predicted."
        # "prostate_7.fasta prostate_7_predicted."
        # "prostate_8.fasta prostate_8_predicted."
        # "prostate_9.fasta prostate_9_predicted."
        # "prostate_10.fasta prostate_10_predicted."
        # "prostate_11.fasta prostate_11_predicted."
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
            # Limit the number of parallel jobs
            while [ $(jobs -r | wc -l) -ge $MAX_JOBS ]; do
                wait
            done
        done
        wait

        # Combine all generated files into a single file
        # combined_file="./hor_results/my.fasta"
        # cat $output_dir/prostate_*_predicted.fasta > "$combined_file"
        # echo "Combined file generated at $combined_file"
    done
else
    echo "Compilation failed."
fi

# Combine all generated files into a single file in a specific order
output_dir=$code\_HOR_data
combined_file="hor_results/$code.fasta"
cat $output_dir/prostate_1_predicted.fasta \
    $output_dir/prostate_2_predicted.fasta \
    $output_dir/prostate_3_predicted.fasta \
    $output_dir/prostate_4_predicted.fasta \
    $output_dir/prostate_5_predicted.fasta \
    $output_dir/prostate_6_predicted.fasta \
    $output_dir/prostate_7_predicted.fasta \
    $output_dir/prostate_8_predicted.fasta \
    $output_dir/prostate_9_predicted.fasta \
    $output_dir/prostate_10_predicted.fasta \
    $output_dir/prostate_11_predicted.fasta > "$combined_file"
echo "Combined file generated at $combined_file"
