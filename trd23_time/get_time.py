import os
import re
import csv

# Define directories to be processed
folders = {"full_10": "trd23_full_10", "full_20": "trd23_full_20"}

# Regex to capture the user and system times from each line of the file
time_pattern = re.compile(r'(\d+\.\d+)user\s+(\d+\.\d+)system')

# Function to parse a file and return the sum of user and system times
def parse_time_file(file_path):
    with open(file_path, 'r') as file:
        content = file.read()
        match = time_pattern.search(content)
        if match:
            user_time = float(match.group(1))
            system_time = float(match.group(2))
            return user_time + system_time
        return None

# Prepare a dictionary to store the times for both full_10 and full_20
time_data = {key: {} for key in folders}

# Process each folder and each file in the folder
for folder_label, folder in folders.items():
    for file_name in os.listdir(folder):
        file_path = os.path.join(folder, file_name)
        
        # Extract the key from the filename (e.g., '5_10' from 'timing_5_10_predicted.txt')
        key = "_".join(file_name.split('_')[1:3])
        
        # Ensure it's a file and calculate the sum of times
        if os.path.isfile(file_path):
            sum_time = parse_time_file(file_path)
            if sum_time is not None:
                time_data[folder_label][key] = sum_time

# Custom sort function to sort keys like '5_3', '10_5' numerically
def sort_keys(key):
    first, second = key.split('_')
    return int(first), int(second)

# Create a sorted list of keys based on the sys+user time identifiers (5_3, 5_5, etc.)
keys = sorted(time_data["full_10"].keys(), key=sort_keys)

# Create a CSV file to store the results with columns for sys+user time, full_10, and full_20
with open('timing_results_full_10_20_sorted.csv', 'w', newline='') as csvfile:
    writer = csv.writer(csvfile)
    
    # Write the header
    writer.writerow(['sys+user time', 'full_10', 'full_20'])
    
    # Write the rows with the time values aligned by the sys+user key
    for key in keys:
        row = [key, time_data["full_10"].get(key, ""), time_data["full_20"].get(key, "")]
        writer.writerow(row)

print("Results written to timing_results_full_10_20_sorted.csv")
