#include <stdio.h>
#include <string.h>

int main () {
   char haystack[20] = "Program.c";
   char needle[10] = ".c";
   char *ret;

   ret = strstr(haystack, needle);

   printf("The substring is: %s\n", ret);
   
   return(0);
}