#include <bits/stdc++.h>

using namespace std;

bool checkRotation(string& s1, string& s2, int indexFound, int Size);
bool evaluateRepeat(string s1, string s2);
int min_three(int x, int y, int z);
int getRotationMinEdit(string true_seq, string predicted_seq);
string get_best_sequence(string true_seq, vector<string> predicted_seqs);

bool checkRotation(string& s1, string& s2, int indexFound, int Size)
{
    for (int i = 0; i < Size; i++) {

        // check whether the character is equal or not
        if (s1[i] != s2[(indexFound + i) % Size])
            return false;
        // %Size keeps (indexFound+i) in bounds, since it
        // ensures it's value is always less than Size
    }

    return true;
}

bool evaluateRepeat(string s1, string s2)
{
	if(s1 == s2) return true;

	vector<int> indexes;

	int seq_size = s1.length();

	char firstChar = s1[0];

	for (int i = 0; i < seq_size; i++) {
		if (s2[i] == firstChar) {
			indexes.push_back(i);
		}
	}

	bool isRotation = false;

	// check if the strings are rotation of each other
	// for every occurrence of firstChar in s2
	for (int idx : indexes) {
		isRotation = checkRotation(s1, s2, idx, seq_size);

		if (isRotation)
			break;
	}

	if (isRotation) return true;

	return false;
}

int min_three(int x, int y, int z) { return std::min(std::min(x, y), z); }

int getEditDistance(string s, string t)
{
	int m = s.size();
	int n = t.size();
	vector<vector<int>> dp(m+1, vector<int>(n+1));
	for(int i=0;i<=m;i++)
	{
		for(int j=0;j<=n;j++)
		{
			dp[i][j]=0;
			if(i==0)dp[i][j]=j;
			else if(j==0)dp[i][j] = i;
		}
	}
	s = " " + s;
	t = " " + t;
	for(int i =1;i<=m;i++)
	{
		for(int j=1;j<=n;j++)
		{
			if(s[i] !=t[j])
			{
				dp[i][j] = 1+min_three(dp[i-1][j],dp[i][j-1],dp[i-1][j-1]);
			}
			else
			{
				dp[i][j] = dp[i-1][j-1];
			}
		}
	}

	int res = dp[m][n];
	return res;
}

int getRotationMinEdit(string true_seq, string predicted_seq)
{
    vector<int> edits;
    string rotated_seq = predicted_seq;

    if(predicted_seq.size() == 1)
    {
        return getEditDistance(true_seq, predicted_seq);
    }

    // cout << "Rotations:" << true_seq << "," << predicted_seq << endl;
    for(int i=0;i<rotated_seq.size();i++)
    {
        string temp = rotated_seq.substr(1,rotated_seq.size()-1) + rotated_seq[0];
        rotated_seq = temp;
        // cout << rotated_seq << endl;
        int res = getEditDistance(true_seq, rotated_seq);
        edits.push_back(res);
    }

    // print edits
    // cout << "printing all edits:" << endl;
    // for(int i=0;i<edits.size();i++)
    // {
    //     cout << "edit:" << edits[i] << endl;
    // }

    if(edits.size() > 0)
    {
       auto min = min_element(edits.begin(),edits.end());
       return *min;
    }

    return -1;
}

string get_best_sequence(string true_seq, vector<string> predicted_seqs)
{
    int best_edit = INT_MAX;
    string best_seq = "";
    for(int i=0;i< predicted_seqs.size();i++)
    {
        int curr_edit = getRotationMinEdit(true_seq, predicted_seqs[i]);
        if(curr_edit < best_edit)
        {
            best_edit = curr_edit;
            best_seq = predicted_seqs[i];
        }
    }
    return best_seq;
}

int main(int argc, const char * argv[]) 
{
    ifstream trueFile, predictedFile;
    ofstream outputFile;
    
    string true_fname = argv[1];
    trueFile.open(true_fname.c_str());

    // Find the start of the first number in the filename
    size_t start = true_fname.find_last_of("/\\") + 1; // Position after last '/' or '\'
    size_t end = true_fname.find('_', start); // Position of first '_' after the start

    // Extract and convert the number from the filename
    int length = 0;
    if (end != string::npos) {
        istringstream(true_fname.substr(start, end - start)) >> length;
    }

    // cout << length << endl;

    string predicted_fname = argv[2];
    predictedFile.open(predicted_fname.c_str());

    string output_fname = argv[3];
	outputFile.open(output_fname.c_str());

    int cas = 50;
    int edit_0 = 0, edit_1 = 0, edit_2 = 0, edit_3 = 0, edit_4 = 0, edit_g_4 = 0, less_10p = 0, less_20p = 0;
    vector<int> edits_list;

    for (int i = 0; i < cas; ++ i) 
    {
        string tmp, true_seq;
        getline(trueFile, tmp);
        getline(trueFile, true_seq);

        outputFile << "Case " << to_string(i) << ":" << endl;
        outputFile << "true:" << true_seq <<endl;

        vector<string> predicted_seqs;
        bool has_nocycle_norepeat = false;

        // Collect all predicted sequences for this case
        while (getline(predictedFile, tmp)) {
            if (tmp.empty() || tmp[0] == '>') {
                // If a new case is starting, break the loop
                if (!predicted_seqs.empty()) break;
            } else {
                if (tmp == "nocycle" || tmp == "norepeat") {
                    has_nocycle_norepeat = true;
                    break;
                }
                predicted_seqs.push_back(tmp); // Store multiple sequences
            }
        }

        if(true_seq.size() > 0 && predicted_seqs.size() > 0)
        {
            // remove whitespave within strings
            true_seq.erase(remove_if(true_seq.begin(), true_seq.end(), ::isspace),true_seq.end());
            for(int i=0;i<predicted_seqs.size();i++)
            {
                string predicted_seq = predicted_seqs[i];
                predicted_seq.erase(remove_if(predicted_seq.begin(), predicted_seq.end(), ::isspace),predicted_seq.end());
            }
        }

        if (has_nocycle_norepeat) {
            outputFile << "predicted:" << "" << endl;
            outputFile << "Edit:" << true_seq.size() << endl << endl;
            if(true_seq.size() == 1) edit_1++;
            else if(true_seq.size() == 2) edit_2++;
            else if(true_seq.size() == 3) edit_3++;
            else if(true_seq.size() == 4) edit_4++;
            else if(true_seq.size() > 4) edit_g_4++;
            edits_list.push_back(true_seq.size());
            continue;
        }

        //get the best of the multiple predicted sequences
        string predicted_seq = get_best_sequence(true_seq, predicted_seqs);

        outputFile << "predicted:" << predicted_seq <<endl;

        int res = getRotationMinEdit(true_seq, predicted_seq);        
        outputFile << "Edit:" << res << endl << endl;

        if(res == 0) edit_0++;
        if(res == 1) edit_1++;
        if(res == 2) edit_2++;
        if(res == 3) edit_3++;
        if(res == 4) edit_4++;
        if(res > 4) edit_g_4++;
        edits_list.push_back(res);
    }

    outputFile << endl;
    outputFile << "Total:" << cas << endl;
    outputFile << "edit_0:" << edit_0 << endl;
    outputFile << "edit_1:" << edit_1 << endl;
    outputFile << "edit_2:" << edit_2 << endl;
    outputFile << "edit_3:" << edit_3 << endl;
    outputFile << "edit_4:" << edit_4 << endl;
    outputFile << "edit_g_4:" << edit_g_4 << endl;

    //calc average edits
    int sum_edits = 0;
    for(int i=0;i<edits_list.size();i++)
    {
        sum_edits += edits_list[i];
        if((float)edits_list[i] <= 10/100.0*length) less_10p++;
        if((float)edits_list[i] <= 20/100.0*length) less_20p++;
    }
    float avg = (float) sum_edits/50.0;
    outputFile << "size of edits_list:" << edits_list.size() << endl;
    outputFile << edit_0 << "," << edit_1 << "," << edit_2 << "," << edit_3 << "," << edit_4 << "," << edit_g_4 << " (" << less_10p << "," << less_20p << "," << avg << ")" << endl;
}



