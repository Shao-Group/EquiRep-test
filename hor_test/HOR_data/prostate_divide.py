# Read the input file
input_file = "prostate_chosen_dotplot_reads.fasta"

# Initialize variables
output_file_prefix = "prostate_"
lines_per_file = 20
file_index = 1

# Open and read all lines from the input file
with open(input_file, 'r') as f:
    lines = f.readlines()

# Get the total number of lines
total_lines = len(lines)

# Loop to write lines to output files
for i in range(0, total_lines, lines_per_file):
    output_file = f"{output_file_prefix}{file_index}.fasta"
    # Write the next 30 lines (or fewer for the last file)
    with open(output_file, 'w') as out_f:
        out_f.writelines(lines[i:i + lines_per_file])
    file_index += 1

print(f"Divided {total_lines} lines into {file_index-1} files.")
