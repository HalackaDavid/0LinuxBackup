void ClearStdin(int x, int y) {
	char ch;
	if (x >= (y - 1)) {
		while((ch = fgetc(stdin)) != '\n' && ch != EOF); //clearing stdin
	}
}
