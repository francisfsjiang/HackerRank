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

void print_move(const vector<Move>& q, int pos) {
    if (pos <= 0) {
        return;
    }
    Move m = q[pos];
    print_move(q, m.last_move);
    cout << DIR[m.dir] << std::endl;
}

void next_move(int posr, int posc, vector <string> board) {
    if(board[posr][posc] == 'd') {
        cout << "CLEAN" << endl;
        board[posr][posc] = '-';
        return;
    }
    vector<Move> q;
    Move head_move, tmp_move = {posr, posc, 0, -1, -1};
    q.push_back(tmp_move);
    int head_pos = 0;
    while (head_pos < q.size()) {
        head_move = q[head_pos];
        for (int d = 0; d < 4; ++d) {
            tmp_move.x = head_move.x + MOVE_X[d];
            tmp_move.y = head_move.y + MOVE_Y[d];
            tmp_move.step_num = head_move.step_num + 1;
            tmp_move.dir = d;
            tmp_move.last_move = head_pos;
            if (
                tmp_move.x >= 0 &&
                tmp_move.y >= 0 &&
                tmp_move.x < n &&
                tmp_move.y < n &&
                vec[tmp_move.x][tmp_move.y] == '-'
            ) {
                q.push_back(tmp_move);
                vec[tmp_move.x][tmp_move.y] = '0';
            }
        }
        ++head_pos;
    }
}

int main(void) {
    int pos[2];
    vector <string> board;
    cin>>pos[0]>>pos[1];
    for(int i=0;i<5;i++) {
        string s;cin >> s;
        board.push_back(s);
    }
    next_move(pos[0], pos[1], board);
    return 0;
}
