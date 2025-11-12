//char s[1024] = "AAAA";
//char *ss = "BBBB";
//append_cStr(s, ss, 4, 4);

char *Strapp(char *str, const char *appStr, int *str_size, const int appStr_size) {
	int start = *str_size;
//	if (appStr_size > 1) {return str;}

    for (int i = 0; i < appStr_size; i++) {
        str[start + i] = appStr[i];
    }

	str[start + appStr_size] = '\0';

	*str_size = start + appStr_size;

    return str;
}
