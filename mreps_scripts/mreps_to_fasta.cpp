#include <bits/stdc++.h>

using namespace std;

#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>
#include <unordered_map>
#include <string>
#include <algorithm>

// Function to split a string by delimiter
vector<string> split(const string& str, char delimiter) {
    vector<string> tokens;
    stringstream ss(str);
    string token;
    while (getline(ss, token, delimiter)) {
        tokens.push_back(token);
    }
    return tokens;
}

vector<string> find_majority_unit(const string& sequence) {
    unordered_map<string, int> unit_count;
    vector<string> units = split(sequence, ' ');

    // Count occurrences of each unit
    for (const auto& unit : units) {
        unit_count[unit]++;
    }

    // Find the maximum count and check if all counts are the same
    int max_count = 0;
    bool all_same_count = true;
    for (const auto& entry : unit_count) {
        if (max_count == 0) {
            max_count = entry.second;
        } else if (entry.second != max_count) {
            all_same_count = false;
        }
        max_count = max(max_count, entry.second);
    }

    // Collect all units with the max count
    vector<string> majority_units;
    for (const auto& entry : unit_count) {
        if (entry.second == max_count) {
            majority_units.push_back(entry.first);
        }
    }

    // If all units have the same count, find the majority length of units
    if (all_same_count) {
        unordered_map<int, int> length_count; // Map to count occurrences of lengths

        // Count the lengths of the units
        for (const auto& unit : units) {
            length_count[unit.length()]++;
        }

        // Find the maximum frequency among lengths
        int majority_length_count = 0;
        int majority_length = 0;
        for (const auto& entry : length_count) {
            if (entry.second > majority_length_count) {
                majority_length_count = entry.second;
                majority_length = entry.first;
            }
        }

        // Collect all units with the majority length
        majority_units.clear();  // Clear previous majority_units
        for (const auto& unit : units) {
            if (unit.length() == majority_length) {
                majority_units.push_back(unit);
            }
        }
    }

    return majority_units;
}


int main(int argc, char* argv[]) {
    if (argc != 3) {
        cerr << "Usage: " << argv[0] << " <input_file> <output_file>\n";
        return 1;
    }

    ifstream infile(argv[1]);
    if (!infile) {
        cerr << "Error opening input file\n";
        return 1;
    }

    ofstream outfile(argv[2]);
    if (!outfile) {
        cerr << "Error opening output file\n";
        return 1;
    }

    string line;
    int sequence_id = -1;
    bool processing_sequence = false;
    string chosen_sequence;
    double max_exp = -1;

    while (getline(infile, line)) {
        // Detect new sequence processing
        if (line.find("Processing sequence") != string::npos) {
            // If we were processing a sequence, write the chosen result to the file
            if (processing_sequence && !chosen_sequence.empty()) {
                vector<string> majority_units = find_majority_unit(chosen_sequence);
                outfile << ">" << sequence_id << "\n";
                
                for (const auto& unit : majority_units) {
                    outfile << unit << "\n";
                }
            }
            else
            {
                if(processing_sequence && chosen_sequence.empty())
                {
                    outfile << ">" << sequence_id << "\n";
                    outfile << "norepeat" << "\n";
                }
            }
            
            // Reset for the new sequence
            processing_sequence = true;
            max_exp = -1;
            chosen_sequence.clear();
            sequence_id = stoi(line.substr(line.find("'") + 1));  // Extract sequence ID
        }

        // Process the sequence table rows
        if (line.find("->") != string::npos && processing_sequence) {
            // Check if the line is not the header
            if (line.find("from   ->") == string::npos) {
                // cout << line << endl;
                vector<string> columns = split(line, '\t');

                // // Print columns for debugging (optional)
                // for (int i = 0; i < columns.size(); i++) {
                //     cout << columns[i] << ";";
                // }
                // cout << endl;

                if (columns.size() >= 5) {
                    // Extract the exp value and sequence column
                    // This assumes the exp value is always the fourth column
                    size_t start_pos = columns[3].find("[") + 1;  // Position after the opening bracket
                    size_t end_pos = columns[3].find("]");        // Position of the closing bracket
                    if (start_pos != string::npos && end_pos != string::npos) {
                        string exp_value_str = columns[3].substr(start_pos, end_pos - start_pos);
                        double exp_value = stod(exp_value_str);  // Convert string to double
                        // cout << exp_value << endl;
                        
                        string sequence = columns[6];
                        
                        // Keep the sequence with the highest exp value
                        if (exp_value > max_exp) {
                            max_exp = exp_value;
                            chosen_sequence = sequence;
                        }
                    }
                }
            }
        }
    }

    // Output the last processed sequence
    if (processing_sequence && !chosen_sequence.empty()) {
        vector<string> majority_units = find_majority_unit(chosen_sequence);
        outfile << ">" << sequence_id << "\n";
        for (const auto& unit : majority_units) {
            outfile << unit << "\n";
        }
    }
    else
    {
        outfile << ">" << sequence_id << "\n";
        outfile << "norepeat" << "\n";
    }


    infile.close();
    outfile.close();

    return 0;
}
