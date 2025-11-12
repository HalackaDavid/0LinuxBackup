#include <stdio.h>
#include <string.h>

#define SIZE 20

int main() {
  char filename[SIZE] = "test.txt";
  printf("%s\n", filename);
  // -4 for .txt
  filename[strlen(filename) - 4] = '\0';
  printf("%s\n", filename);
  return 0;
}