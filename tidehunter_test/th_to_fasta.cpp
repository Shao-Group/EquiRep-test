#include <bits/stdc++.h>

using namespace std;

int main(int argc, const char * argv[]) 
{
    ifstream inputFile;
    ofstream outputFile;

    string input_fname = argv[1];
    string output_fname = argv[2];

    inputFile.open(input_fname.c_str());
    outputFile.open(output_fname.c_str());

    // Total number of instances
    int total_instances = 50;

    // Map to store the sequences and column 3 values for instances
    map<int, pair<double, string>> instance_sequences;  // Map to store <column_3_value, sequence>

    string line;

    // Reading the input file
    while (getline(inputFile, line)) {
        stringstream ss(line);
        int instance;
        string temp, column11_sequence;
        double column_3_value;

        // Read the instance (first column)
        ss >> instance;

        // Read the 3rd column (skip the 2nd column)
        ss >> temp;  // Skip 2nd column
        ss >> column_3_value;  // Read 3rd column (which could be decimal)

        // Skip to the 11th column
        for (int i = 4; i <= 10; ++i) {
            ss >> temp;
        }

        // The 11th column is the sequence we need
        ss >> column11_sequence;

        // If the instance already exists, only update if column_3_value is greater
        if (instance_sequences.find(instance) == instance_sequences.end() || instance_sequences[instance].first < column_3_value) {
            instance_sequences[instance] = {column_3_value, column11_sequence};
        }
    }

    // Writing to the output file
    for (int i = 0; i < total_instances; ++i) {
        outputFile << ">" << i << endl;

        if (instance_sequences.find(i) != instance_sequences.end()) {
            // If the instance exists, write the sequence
            outputFile << instance_sequences[i].second << endl;
        } else {
            // If the instance doesn't exist, write "norepeat"
            outputFile << "norepeat" << endl;
        }
    }

    inputFile.close();
    outputFile.close();

    return 0;
}
