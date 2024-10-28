#include <bits/stdc++.h>
using namespace std;

ofstream    oF;
ifstream    iF, iF2;

int semiGlobalAlignment(const string& A, const string& B) {
    // cout << "  string A: " << A << '\n';
    // cout << "  string B: " << B << '\n';
    int n = A.size();
    int m = B.size();
    
    vector<vector<int>> dp(n + 1, vector<int>(m + 1, INT_MAX));

    for (int j = 0; j <= m; ++ j) {
        dp[0][j] = 0;
    }

    for (int i = 1; i <= n; ++ i) {
        dp[i][0] = i;
    }
    
    for (int i = 1; i <= n; ++i) {
        for (int j = 1; j <= m; ++j) {
            if (A[i - 1] == B[j - 1]) {
                dp[i][j] = dp[i - 1][j - 1];
            } else {
                dp[i][j] = 1 + min({dp[i - 1][j], dp[i][j - 1], dp[i - 1][j - 1]});
            }
        }
    }
    
    int minDist = INT_MAX;
    for (int j = 1; j <= m; ++j) {
        minDist = min(minDist, dp[n][j]);
    }
    
    return minDist;
}

int main(int argc, const char * argv[]) {
    string fn1 = argv[1], fn2 = argv[2], out_fn = argv[3];
    iF.open(fn1);
    iF2.open(fn2);
    oF.open(out_fn);
    string header, seq, unit, tmp;
    double sum_ed = 0, cnt = 0;
    int r05 = 0, r9 = 0, r8 = 0, r7 = 0, r5 = 0, r2 = 0;
    while (getline(iF2, header)){
        getline(iF, tmp);
        getline(iF, seq);
        getline(iF2, unit);
        string seq2 = "";
        for (int i = 0; i < seq.length() / unit.length() + 2; ++ i) {
            seq2 += unit;
        }
        int ed = semiGlobalAlignment(seq, seq2);
        oF << header << '\n';
        sum_ed += ed;
        ++ cnt;
        double rate1 = ed;
        rate1 = rate1 / seq.length();
        oF << ed << ' ' << rate1 << '\n';
        if (rate1 <= 0.05) {
            ++ r05;
        }
        if (rate1 <= 0.1) {
            ++ r9;
        }
        if (rate1 <= 0.2) {
            ++ r8;
        }
        if (rate1 <= 0.3) {
            ++ r7;
        }
        if (rate1 <= 0.5) {
            ++ r5;
        }
        if (rate1 <= 0.8) {
            ++ r2;
        }
    }
    oF << "avg_ed: " << sum_ed / cnt << '\n';
    oF << "<= 0.05 (5%): " << r05 << '\n';
    oF << "<= 0.1 (10%): " << r9 << '\n';
    oF << "<= 0.2 (20%): " << r8 << '\n';
    oF << "<= 0.3 (30%): " << r7 << '\n';
    oF << "<= 0.5 (50%): " << r5 << '\n';
    oF << "<= 0.8 (80%): " << r2 << '\n';
    return 0;
}