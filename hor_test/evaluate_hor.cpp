#include <bits/stdc++.h>

using namespace std;

bool checkRotation(string& s1, string& s2, int indexFound, int Size);
bool evaluateRepeat(string s1, string s2);
int min_three(int x, int y, int z);

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

int main(int argc, const char * argv[]) 
{
    ifstream trueFile, predictedFile;
    ofstream outputFile;
    
    string true_fname = argv[1];
    trueFile.open(true_fname.c_str());

    string predicted_fname = argv[2];
    predictedFile.open(predicted_fname.c_str());

    string output_fname = argv[3];
	outputFile.open(output_fname.c_str());

    string header, tmp, true_seq="", predicted_seq="";
    while(getline(predictedFile, header))
    {
        if(header[0] == '>')
        {
            getline(predictedFile, predicted_seq);
            if(predicted_seq.size() > 0)
            {
                predicted_seq.erase(remove_if(predicted_seq.begin(), predicted_seq.end(), ::isspace),predicted_seq.end());
            }

            if(predicted_seq == "nocycle" || predicted_seq == "norepeat")
            {
                predicted_seq = "";
            }

            outputFile << header << endl;

            vector<int> edits_list;

            // Reset the trueFile to the beginning for each predicted sequence
            trueFile.clear();  // clear any EOF flag
            trueFile.seekg(0); // set the file pointer to the beginning of trueFile
            while(getline(trueFile,tmp))
            {
                if(tmp[0] == '>')
                {
                    getline(trueFile, true_seq);
                    outputFile << "t:" << true_seq <<endl;
                    outputFile << "p:" << predicted_seq <<endl;

                    if(true_seq.size() > 0 && predicted_seq.size() == 0)
                    {
                        edits_list.push_back(true_seq.size());
                        outputFile << "Edit: " << true_seq.size() << endl;
                    }
                    else if(true_seq.size() > 0 && predicted_seq.size() > 0)
                    {
                        int res = getRotationMinEdit(true_seq, predicted_seq);   
                        edits_list.push_back(res);     
                        outputFile << "Edit:" << res << endl;
                    }
                }
            }

            int sum_edits = 0;
            for(int i=0;i<edits_list.size();i++)
            {
                sum_edits += edits_list[i];
            }

            outputFile << "sum: " << sum_edits << endl;
            outputFile << "avg: " << (float) sum_edits/edits_list.size() << endl << endl; 
        }
    }

    return 0;
}



