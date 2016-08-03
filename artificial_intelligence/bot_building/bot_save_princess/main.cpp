#include <iostream>
#include <vector>

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


int main(int argc, const char* argv[]) {
    int n;
    string s;
    vector<string> vec;
    cin >> n;
    for (int i = 0; i < n ; ++i) {
        cin >> s;
        vec.push_back(s);
    }

    int bot_x, bot_y, princess_x, princess_y;

    for(int i = 0; i < n; ++i) {
        for (int j = 0; j < n; ++j) {
            if(vec[i][j] == 'm'){
                bot_x = i;
                bot_y = j;
            }
            if (vec[i][j] == 'p') {
                princess_x = i;
                princess_y = j;
            }
        }
    }
    vector<Move> q;
    Move head_move, tmp_move = {bot_x, bot_y, -1, -1};
    q.push_back(tmp_move);
    int head_pos = 0;
    while (head_pos < q.size()) {
        head_move = q[head_pos];
        for (int d = 0; d < 4; ++d) {
            tmp_move.x = head_move.x + MOVE_X[d];
            tmp_move.y = head_move.y + MOVE_Y[d];
            tmp_move.dir = d;
            tmp_move.last_move = head_pos;
            if (tmp_move.x == princess_x &&
                tmp_move.y == princess_y) {
                    q.push_back(tmp_move);
                    print_move(q, q.size()-1);
                    return 0;
            }
            else if (
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
    return 0;
}
