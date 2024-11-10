import os
import pandas as pd

# Define the base directory and subfolders
method = "TRF"  # to change
base_dir = "../data/simulated_data/dat3"
# Replace dat3 with dat_aax2 or dat_aax3 to test on other simulated data
subfolders = ["./error_10/TRF_results", "./error_20/TRF_results"]

# List of (x, y) combinations to look for
combinations = [
    (5, 3),   (5, 5),   (5, 10),   (5, 20),
    (10, 3),  (10, 5),  (10, 10),  (10, 20),
    (50, 3),  (50, 5),  (50, 10),  (50, 20),
    (200, 3), (200, 5), (200, 10), (200, 20),
    (500, 3), (500, 5), (500, 10), (500, 20)
]

# Prepare the output data structure
data = {folder: [] for folder in subfolders}
rows = []

# Loop through each (x, y) combination
for (x, y) in combinations:
    row = f"{x},{y}"
    rows.append(row)
    for folder in subfolders:
        try:
            # Construct the file path
            file_path = os.path.join(base_dir, folder, f"eval_trf_{x}_{y}_my.txt")
            print(file_path)
            # Read the last line of the file
            with open(file_path, 'r') as file:
                lines = file.readlines()
                if lines:  # Check if the file is not empty
                    last_line = lines[-1].strip()  # Get the last line and remove any trailing spaces or newline
                    data[folder].append(last_line)
                else:
                    data[folder].append('Empty')  # If the file is empty
        except FileNotFoundError:
            data[folder].append('N/A')  # File not found

# Convert to a DataFrame and save as CSV
df = pd.DataFrame(data, index=rows)
output_file = f"./{method}_results_sum.csv"
df.to_csv(output_file, index=True, header=True)

print(f"Results saved to {output_file}")