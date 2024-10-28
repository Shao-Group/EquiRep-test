import os

# File paths and methods
base_dir = '/datadisk1/zps5227/rf1/hor_test/'
methods = ['EQUIREP', 'TRF', 'MTR', 'mreps', 'TH']
result_dir_template = os.path.join(base_dir, 'EQUIREP_results_prostate_chosen_dotplot_reads')
stat_file = os.path.join(base_dir, 'hor_results', 'prostate_chosen_dotplot_reads.stat')

# Tolerance ranges
tolerance_ranges = [
    (0.99, 1.01),  # 5% tolerance
    (0.98, 1.02),  # 5% tolerance
    (0.97, 1.03),  # 5% tolerance
    (0.96, 1.04),  # 5% tolerance
    (0.95, 1.05),  # 5% tolerance
    (0.8, 1.2),    # 20% tolerance
    (0.5, 1.5),    # 50% tolerance
    (0.2, 1.8)     # 80% tolerance
]

# Read stat file and store true lengths and copy numbers
def read_stat_file(stat_file):
    true_lengths = {}
    with open(stat_file, 'r') as stat:
        for line in stat:
            if line.startswith(">"):
                header = line.strip().split()[0][1:]  # Extract header without '>'
            else:
                length, _ = map(float, line.strip().split())
                true_lengths[header] = length
    return true_lengths

# Evaluate fasta files and compute statistics manually (no BioPython)
def evaluate_fasta(fasta_file, true_lengths):
    total_sequences = 0
    within_ranges = [0, 0, 0, 0, 0, 0, 0, 0]
    norepeats = 0
    current_header = None
    predicted_length = 0
    sequence = ''

    with open(fasta_file, 'r') as file:
        for line in file:
            line = line.strip()

            if line.startswith('>'):  # New header
                # Process the previous sequence if applicable
                if current_header is not None:
                    total_sequences += 1
                    if sequence == "norepeat":
                        norepeats += 1
                    else:
                        predicted_length = len(sequence)
                        # Print the predicted length for debugging
                        print(f"Predicted length for {current_header}: {predicted_length}")

                        # Compare predicted length to true length
                        if current_header in true_lengths:
                            true_length = true_lengths[current_header]
                            # Print the true length for debugging
                            print(f"True length for {current_header}: {true_length}")

                            for i, (low, high) in enumerate(tolerance_ranges):
                                if low * true_length <= predicted_length <= high * true_length:
                                    within_ranges[i] += 1

                # Reset for the new sequence
                current_header = line.split()[0][1:]  # Remove '>'
                sequence = ''

            else:
                sequence += line  # Append sequence data

        # Process the last sequence after reading the file
        if current_header is not None:
            total_sequences += 1
            if sequence == "norepeat":
                norepeats += 1
            else:
                predicted_length = len(sequence)
                # Print the predicted length for the last sequence
                print(f"Predicted length for {current_header}: {predicted_length}")

                if current_header in true_lengths:
                    true_length = true_lengths[current_header]
                    # Print the true length for the last sequence
                    print(f"True length for {current_header}: {true_length}")

                    for i, (low, high) in enumerate(tolerance_ranges):
                        if low * true_length <= predicted_length <= high * true_length:
                            within_ranges[i] += 1

    return total_sequences, within_ranges, norepeats




# Main function to process all methods
def process_methods():
    true_lengths = read_stat_file(stat_file)
    print(true_lengths)

    # for method in methods:
    # Update result directory and fasta file name for each method
    result_dir = "./"
    fasta_file = "hor_results/trd23.fasta"
    #th_prostate_chosen_dotplot_reads

    if not os.path.exists(fasta_file):
        print(f"Fasta file for {method} not found. Skipping...")

    # Evaluate the fasta file
    total_sequences, within_ranges, norepeats = evaluate_fasta(fasta_file, true_lengths)

    # Write results to evaluation file
    output_file = "./szz.txt"
    with open(output_file, 'w') as outfile:
        outfile.write(f"Evaluation of  on prostate_chosen_dotplot_reads\n")
        outfile.write(f"Total sequences: {total_sequences}\n")
        outfile.write(f"Within 1% tolerance: {within_ranges[0]}\n")
        outfile.write(f"Within 2% tolerance: {within_ranges[1]}\n")
        outfile.write(f"Within 2% tolerance: {within_ranges[2]}\n")
        outfile.write(f"Within 4% tolerance: {within_ranges[3]}\n")
        outfile.write(f"Within 5% tolerance: {within_ranges[4]}\n")
        outfile.write(f"Within 20% tolerance: {within_ranges[5]}\n")
        outfile.write(f"Within 50% tolerance: {within_ranges[6]}\n")
        outfile.write(f"Within 80% tolerance: {within_ranges[7]}\n")
        outfile.write(f"Number of norepeats: {norepeats}\n")
    
    print(f"Results for  written to {output_file}")

if __name__ == "__main__":
    process_methods()
