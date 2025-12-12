#include <ncurses.h>
#include <string>

//compile
//g++ -o c i.cpp -lncurses

int main() {
    initscr();              // Start ncurses mode
    cbreak();               // Disable line buffering
    noecho();               // Don't echo input
    keypad(stdscr, TRUE);   // Enable arrow keys
    curs_set(0);            // Hide cursor

    while (1) {
        clear();            // Clear screen

        int rows, cols;
        getmaxyx(stdscr, rows, cols);
		mvprintw(0, 8, "Screen size: %dx%d", rows, cols);
        mvprintw(1, 8, "Press 'q' to quit");
		for (int i = 0; i < rows; i++) {
			mvprintw(i, 0, std::to_string(i).c_str());
		}
        int ch = getch();
        if (ch == 'q') break;

        refresh();          // Refresh screen
    }

    endwin();               // End ncurses mode
    return 0;
}

