/*
    Generate full read with tandem repeat
*/

#include <bits/stdc++.h>
#define pii pair <int, int>
using namespace std;

pii nm[] = {    
                // {5, 3},     {5, 5},     {5, 10},    {5, 20},    {5, 50},
                // {10, 3},    {10, 5},    {10, 10},   {10, 20},   {10, 50},
                {50, 3},    {50, 5},    {50, 10},   {50, 20},   {50, 50},
                {200, 3},   {200, 5},   {200, 10},  {200, 20},  {200, 50},
                {500, 3},   {500, 5},   {500, 10},  {500, 20}
            };
char alp[4] = {'A', 'C', 'G', 'T'};
int cas = 50;
int eins, edel, erep, totp;
int ta, tb, tc, tot;

void GenerateTRReads(string folder, int rate);
void TestRandom(int cur);

int main(int argc, const char * argv[]) {
    string folder = argv[1];
    GenerateTRReads(folder, 10);
    GenerateTRReads(folder, 20);
    return 0;
}

/*
    Generate the tandem repeat sequences
*/
void GenerateTRReads(string folder, int rate) {
    cout << "Generating reads with tandem repeat (full string):\n";
    if (rate == 5)
        eins = 5, edel = 5, erep = 5, totp = 300; // error rate = 15/300 = 5%
    else if (rate == 10)
        eins = 10, edel = 10, erep = 10, totp = 300; // error rate = 30/300 = 10%
    else if (rate == 15)
        eins = 10, edel = 10, erep = 10, totp = 200; // error rate = 30/200 = 15%
    else if (rate == 20)
        edel = 10, erep = 10, eins = 10, totp = 150; // error rate = 30/150 = 20%
    else {
        cout << "Not predefined rate!\n";
        return;
    }
    tot = 0, ta = 0, tb = 0, tc = 0;
    mt19937 myrand(time(0));
    int num = 0;
    for (auto x : nm) {
        int n = x.first, m = x.second;
        ofstream oF, oF_ans, oF_eq;
        string fn = "full_" + to_string(rate) + "/" + 
            to_string(n) + "_" + to_string(m) + "_my.fasta";
        string ans_fn = "full_" + to_string(rate) + "/" +
            to_string(n) + "_" + to_string(m) + "_ans.fasta";
        string eq_fn = "full_" + to_string(rate) + "/" + 
            to_string(n) + "_" + to_string(m) + "_eq.fasta";
        string info_fn = "full_" + to_string(rate) + "/" + 
            to_string(n) + "_" + to_string(m) + "_info.fasta";
        fn = "./" + folder + "/" + fn;
        ans_fn = "./" + folder + "/" + ans_fn;
        info_fn = "./" + folder + "/" + info_fn;
        eq_fn = "./" + folder + "/" + eq_fn;
        oF.open(fn);
        oF_ans.open(ans_fn);
        oF_eq.open(eq_fn);
        for (int T = 0; T < cas; ++ T) {
            // Generate the repeat unit
            string unit = "";
            while ( unit == "" ||
                    unit == "AAAAA" ||
                    unit == "CCCCC" ||
                    unit == "GGGGG" ||
                    unit == "TTTTT") {
                unit = "";
                int a_size;
                if (n == 50)
                    a_size = 5;
                else if (n == 200)
                    a_size = 10;
                else if (n == 500)
                    a_size = 20;
                else
                    cout << "NOOOOOOOOOOOOOO\n";
                // cout << "a_size: " << a_size << '\n';
                
                string a_unit = "";

                for (int i = 0; i < a_size; ++ i)
                    a_unit += alp[myrand() % 4];
                for (int i = 0; i < n - 3 * a_size; ++ i)
                    unit += alp[myrand() % 4];
                unit = a_unit + a_unit + a_unit + unit;
            }
            oF_ans << ">" << T << '\n' << unit << '\n';

            // Generate the repeat region
            string tmp;
            for (int i = 0; i < m; ++ i)
                tmp += unit;
            string repeats, info;
            vector <int> cls[509];
            for (int i = 0; i < tmp.length(); ++ i) {
                int cur = myrand() % totp; TestRandom(cur);
                while (cur < eins) {
                    repeats += alp[myrand() % 4];
                    cur = myrand() % totp; TestRandom(cur);
                }
                if (cur < eins + edel)
                    continue;
                else if (cur < eins + edel + erep) {
                    char ty = alp[myrand() % 4];
                    while (ty == tmp[i]) {
                        ty = alp[myrand() % 4];
                    }
                    repeats += ty;
                    // cls[i % n].push_back(repeats.length() - 1);
                }
                else {
                    repeats += tmp[i];
                    cls[i % n].push_back(repeats.length() - 1);
                }
            }

            // Output eq
            oF_eq << ">" << T << '\n';
            for (int i = 0; i < n; ++ i) {
                if (!cls[i].empty()) {
                    oF_eq << i << ": ";
                    for (auto x : cls[i])
                        oF_eq << x << ' ';
                    oF_eq << '\n';
                }
            }

            // Generate the two random parts and the full string
            string tmp1, tmp2;
            for (int i = 0; i < n * m; ++ i) {
                tmp1 += alp[myrand() % 4];
                tmp2 += alp[myrand() % 4];
            }
            string full_string = tmp1 + repeats + tmp2;
            oF << ">" << T << '\n' << full_string << '\n';
        }
        oF.close();
        oF_ans.close();
        oF_eq.close();
        ++ num;
    }
    cout << "  Error rate: " << (double) (eins + edel + erep) / totp << '\n';
    cout << "  TestRandom: " << ta << ' ' << tb << ' ' << tc << ' ' << tot << '\n';
    cout << "  Rate: " << (double) ta / tot << ' ' << (double) tb / tot << ' ' << (double) tc / tot << '\n';
    cout << "  Total Rate: " << (double) (ta + tb + tc) / tot << '\n';
    cout << '\n';
}

/*
    Test the randomness of the data
*/
void TestRandom(int cur) {
    ++ tot;
    if (cur < eins)
        ++ ta;
    else if (cur < eins + edel)
        ++ tb;
    else if (cur < eins + edel + erep)
        ++ tc;
}