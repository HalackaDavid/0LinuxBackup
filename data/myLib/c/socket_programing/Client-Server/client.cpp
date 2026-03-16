#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <sys/socket.h>

int main() {
	int sock = 0;
	struct sockaddr_in serv_addr;
	char buffer[1024] = {0};

	// 1. Create socket
	sock = socket(AF_INET, SOCK_STREAM, 0);
	if (sock < 0) {
		perror("Socket crration error");
		return -1;
	}

	// 2. Define server address
	serv_addr.sin_family = AF_INET;
	serv_addr.sin_port = htons(8080);

	// Convert IPv4 address from text to binary
	if (inet_pton(AF_INET, "127.0.0.1", &serv_addr.sin_addr) <= 0) {
		perror("Invalid address / Address not supported");
		return -1;
	}

	// 3. Connect to the server
	if (connect(sock, (struct sockaddr *)&serv_addr, sizeof(serv_addr)) < 0) {
		perror("Connection failed");
		return -1;
	}

	// 4. Send message
	send(sock, "Hello from client", strlen("Hello from client"), 0);
	printf("Message sent to server\n");

	// 5. Read response
	read(sock, buffer, 1024);
	printf("Message from server: %s\n", buffer);

	// 6. clean up
	close(sock);
	return 0;
}
