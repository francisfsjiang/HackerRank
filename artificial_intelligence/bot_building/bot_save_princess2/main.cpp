#include <iostream>
#include <vector>
using namespace std;
void nextMove(int n, int r, int c, vector <string> grid){
    int bot_x, bot_y, princess_x, princess_y;
    for(int i = 0; i < n; ++i) {
        for (int j = 0; j < n; ++j) {
            if(grid[i][j] == 'm'){
                bot_x = i;
                bot_y = j;
            }
            if (grid[i][j] == 'p') {
                princess_x = i;
                princess_y = j;
            }
        }
    }

    if (bot_x > princess_x) {
        cout << "UP" << endl;
    }
    else if (bot_x == princess_x) {
        if (bot_y > princess_y) {
            cout << "LEFT" << endl;
        }
        else {
            cout << "RIGHT" << endl;
        }
    }
    else {
        cout << "DOWN" << endl;
    }
}
int main(void) {

    int n, r, c;
    vector <string> grid;

    cin >> n;
    cin >> r;
    cin >> c;

    for(int i=0; i<n; i++) {
        string s; cin >> s;
        grid.push_back(s);
    }

    nextMove(n, r, c, grid);
    return 0;
}
