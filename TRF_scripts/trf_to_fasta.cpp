#include <bits/stdc++.h>

using namespace std;

struct Data {
    int instance;
    double column4;
    string column14_sequence;
};

void printDataMap(const std::map<int, std::vector<Data>>& data_map) {
    for (const auto& entry : data_map) {
        std::cout << "Instance @" << entry.first << ":\n";
        for (const auto& data : entry.second) {
            std::cout << "  Column 4: " << data.column4 
                      << ", Column 14 Sequence: " << data.column14_sequence << "\n";
        }
    }
}

int main(int argc, const char * argv[]) 
{
    ifstream inputFile;
    ofstream outputFile;

    string input_fname = argv[1];
    string output_fname = argv[2];

    inputFile.open(input_fname.c_str());
    outputFile.open(output_fname.c_str());

    int cas = 50;

    map<int, vector<Data>> data_map;
    string line;
    int current_instance = -1;

    while (getline(inputFile, line)) {
        if (line[0] == '@') {
            current_instance = stoi(line.substr(1));
        } else {
            if (current_instance != -1) {
                Data d;
                d.instance = current_instance;
                stringstream data_ss(line);
                string temp;
                int column = 1;
                while (data_ss >> temp) {
                    if (column == 4) {
                        d.column4 = std::stod(temp);
                    }
                    if (column == 14) {
                        d.column14_sequence = temp;
                    }
                    column++;
                }
                data_map[current_instance].push_back(d);
            }
        }
    }

    // Print the data map for debugging
    // printDataMap(data_map);

    for (int i = 0; i < cas; i++) {
        if (data_map.find(i) == data_map.end()) {
            outputFile << ">" << to_string(i) << endl;
            outputFile << "norepeat" << endl;
        } else {
            auto &entries = data_map[i];
            auto max_entry = std::max_element(entries.begin(), entries.end(), [](const Data &a, const Data &b) {
                return a.column4 < b.column4;
            });
            outputFile << ">" << to_string(i) << endl;
            outputFile << max_entry->column14_sequence << endl;
        }
    }

    inputFile.close();
    outputFile.close();

    return 0;
}