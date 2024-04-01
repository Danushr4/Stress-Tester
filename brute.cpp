#include <iostream>
#include <vector>

using namespace std;

void weird(int n, vector<int>& res) {
    while (n != 1) {
        res.push_back(n);
        if (n % 2 == 0) {
            n /= 2;
        } else {
            n = n * 3 + 1;
        }
    }
    res.push_back(1);
}

int main() {
    int n;
    cin >> n;

    vector<int> res;

    weird(n, res);

    for (int m : res) {
        cout << m << " ";
        //cout << m;
    }

    return 0;
}

