#include <string.h>

#if cstring is equal to another

int strncmp(const char s1[.n], const char s2[.n], size_t n);
---> strncmp("ABC", "ABC", 1) -> checks if first character is equal
---> strncmp("ABC", "ABC", 2) -> checks if first two characters are equal
---> strncmp("ABC", "ABC", 3) -> checks if first three characters are equal

int strcmp(const char *s1, const char *s2);
---> if strings are equal to another
