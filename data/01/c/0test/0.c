//Library

int main()
{
    return 0;
}

void clear() 
{
	#ifdef _WIN32
	    system("cls");
	#elif __linux__
	    system("clear");
	#elif __unix__
	    system("clear");
	#else
	    system("clear");
	#endif
}