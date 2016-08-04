#include<iostream>
#include<vector>
using namespace std;

int MOVE_X[] = {-1,  1,  0,  0};
int MOVE_Y[] = { 0,  0, -1,  1};

char DIR[][6] = {
    "UP",
    "DOWN",
    "LEFT",
    "RIGHT"
};

struct Move {
    int x, y;
    int step_num;
    int last_move;
    int dir;
};

struct BestMove {

};

const int MAX = 999999;

int dfs(int x, int y, int left_target, vector<string>& board, int step) {
    if (x < 0 || y < 0 || x >= 5 || y >=5 || board[x][y] == '0') {
        return MAX;
    }
    int is_dirty = 0;
    if (board[x][y] == 'd') {
        if (left_target == 1) {
//            cout << step << endl;
//            for (int i = 0; i < 5; ++i) {
//                for (int j = 0; j < 5; ++j) {
//                    cout << board[i][j];
//                }
//                cout << endl;
//            }
//            cout << endl << endl;
            return 1;
        }
        else {
            is_dirty = 1;
        }
    }
    int min = MAX;
    board[x][y] = '0';
    int tmp = 0;
    for (int i = 0; i < 4; ++i) {
        tmp = dfs(x + MOVE_X[i], y + MOVE_Y[i], left_target - is_dirty, board, step + 1);
        if (tmp < min) {
            min = tmp;
        }
    }
    if (is_dirty == 1) board[x][y] = 'd';
    else board[x][y] = '-';
    return min + 1;
}


void next_move(int posr, int posc, vector <string> board) {
    if(board[posr][posc] == 'd') {
        cout << "CLEAN" << endl;
        board[posr][posc] = '-';
        return;
    }
    int target_num = 0;
    for (int i = 0; i < 5; ++i) {
        for (int j = 0; j < 5; ++j) {
            if (board[i][j] == 'd') {
                ++target_num;
            }
        }
    }

    board[posr][posc] = '0';
    int min = MAX, dir = 0, tmp;
    for (int i = 0; i < 4; ++i) {
        tmp = dfs(posr + MOVE_X[i], posc + MOVE_Y[i], target_num, board, 0);
        if (tmp < min) {
            min = tmp;
            dir = i;
        }
    }
//    cout << min << endl;
    cout << DIR[dir] << endl;
}

int main(void) {
    freopen("in.in", "r", stdin);
    freopen("log", "w+", stdout);
    int pos[2];
    vector <string> board;
    cin>>pos[0]>>pos[1];
    for(int i=0;i<5;i++) {
        string s;cin >> s;
        board.push_back(s);
    }
    next_move(pos[0], pos[1], board);
    next_move(1,0, board);
    next_move(1,1, board);
    return 0;
}
