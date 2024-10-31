#include <bits/stdc++.h>

using namespace std;

struct Data {
    int instance;
    double column7;
    string column12_sequence;
};

void printDataMap(const std::map<int, std::vector<Data>>& data_map) {
    for (const auto& entry : data_map) {
        std::cout << "Instance @" << entry.first << ":\n";
        for (const auto& data : entry.second) {
            std::cout << "  Column 7: " << data.column7 
                      << ", Column 12 Sequence: " << data.column12_sequence << "\n";
        }
    }
}

int main(int argc, const char * argv[]) 
{
    ofstream outputFile;

    string output_dir = argv[1];
    string number_part = argv[2];
    string input_base = argv[3];
    string output_fname = argv[4];

    // inputFile.open(input_fname.c_str());
    outputFile.open(output_fname.c_str());

    int cas = 50;
    map<int, vector<Data>> data_map;

    for (int i = 0; i < cas; i++)
    {
        string input_fname = string(output_dir) + "/" + string(number_part) + "my/"  + string(input_base) + to_string(i) + ".out";
        cout << input_fname << endl;

        ifstream inputFile;
        inputFile.open(input_fname.c_str());

        if(inputFile.peek() == EOF)
        {
            // cout << "empty" << endl;
            continue;
        }

        string line;
        while (getline(inputFile, line))
        {
            // cout << "line:" << line << endl;
            Data d;
            d.instance = i;
            stringstream data_ss(line);
            string temp;
            int column = 1;
            while (data_ss >> temp) {
                // cout << "column:" << column << endl;
                // cout << "temp:" << temp << endl;
                if (column == 7) {
                    d.column7 = std::stod(temp);
                    // cout << "7:" << temp << endl;
                }
                if (column == 12) {
                    d.column12_sequence = temp;
                    // cout << "12:" << temp << endl;
                }
                column++;
            }
            data_map[i].push_back(d);
        }

        //Print the data map for debugging
        // printDataMap(data_map);
    }

    for (int i = 0; i < cas; i++)
    {
        if (data_map.find(i) == data_map.end()) {
            outputFile << ">" << to_string(i) << endl;
            outputFile << "norepeat" << endl;
        } else {
            auto &entries = data_map[i];
            auto max_entry = std::max_element(entries.begin(), entries.end(), [](const Data &a, const Data &b) {
                return a.column7 < b.column7;
            });
            outputFile << ">" << to_string(i) << endl;
            outputFile << max_entry->column12_sequence << endl;
        }
    }
}