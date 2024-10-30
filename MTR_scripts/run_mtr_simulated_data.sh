#!/bin/bash

file=$1 #simulation15
tool_dir=/data/tkz5115/repeat_project/tools/mTR
input_dir=/data/tkz5115/repeat_project/data/dat3/$file
output_dir=/data/tkz5115/repeat_project/data/dat3/$file/MTR_results

mkdir -p $output_dir

# Array of parameters for generating trf output files
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
    # output_file="$output_dir/mtr_${number_part}my.out"
    output_subdir=$output_dir/${number_part}my

    mkdir $output_subdir
    echo $param
    
    seq_number=0
    sequence=""

    while read -r line; do
        if [[ $line == ">"* ]]; then
            if [[ -n $sequence ]]; then
                echo "$sequence" > $output_subdir/"tmp_$seq_number.fasta"
                seq_number=$((seq_number + 1))
            fi
            echo "$line" > $output_subdir/"tmp_$seq_number.fasta"
            sequence=""
        else
            sequence="$line"
        fi
    done < "$param"

    # Print the last sequence
    if [[ -n $sequence ]]; then
        echo "$sequence" > $output_subdir/"tmp_$seq_number.fasta"
    fi

    for i in {0..49}; do
        $tool_dir/mTR $output_subdir/"tmp_""$i"".fasta" > $output_subdir/mtr_${number_part}case${i}.out
    done

    rm $output_subdir/tmp*
done

# Compile the program
g++ -o mtr_to_fasta mtr_to_fasta.cpp -std=c++11

if [ $? -eq 0 ]; then
    echo "mtr_to_fasta compilation successful."

    params=(
        "5_2_my"
        "5_3_my"
        "5_4_my"
        "5_5_my"
        "5_10_my"
        "5_20_my"
        "5_50_my"
        "5_100_my"
        "5_200_my"

        "10_2_my"
        "10_3_my"
        "10_4_my"
        "10_5_my"
        "10_10_my"
        "10_20_my"
        "10_50_my"
        "10_100_my"
        "10_200_my"

        "20_2_my"
        "20_3_my"
        "20_4_my"
        "20_5_my"
        "20_10_my"
        "20_20_my"
        "20_50_my"
        "20_100_my"

        "50_2_my"
        "50_3_my"
        "50_4_my"
        "50_5_my"
        "50_10_my"
        "50_20_my"
        "50_50_my"
        "50_100_my"

        "100_2_my"
        "100_3_my"
        "100_4_my"
        "100_5_my"
        "100_10_my"
        "100_20_my"
        "100_30_my"

        "200_2_my"
        "200_3_my"
        "200_4_my"
        "200_5_my"
        "200_10_my"
        "200_20_my"
        "200_50_my"

        "500_2_my"
        "500_3_my"
        "500_4_my"
        "500_5_my"
        "500_10_my"
        "500_20_my"
    )

    # Loop through each parameter
    for param in "${params[@]}"
    do
        # Extract the number
        number_part="${param%my*}"
        # echo $number_part
        base=mtr_${number_part}case
        out_file="${output_dir}/mtr_${number_part}my.fasta"

        ./mtr_to_fasta $output_dir $number_part $base $out_file
        
    done
else
    echo "Compilation failed."
fi





