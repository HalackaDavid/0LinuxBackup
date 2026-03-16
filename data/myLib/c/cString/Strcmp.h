int Strcmp(const char *str1, const char *str2) {
	int len1 = 0; while(str1[len1] != '\0') {len1++;}
	int len2 = 0; while(str2[len2] != '\0') {len2++;}

	if (len1 == len2) {
		for (int i = 0; i < len1; i++) {
			if (str1[i] != str2[i]) {
				return 0; //not equal
			}
		}
		return 1; //equal
	}
	return 0; //not equal
}
