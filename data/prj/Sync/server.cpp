#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <sys/socket.h>

int main() {
	struct sockaddr_in {
		sin_family = AF_INET;
		sin_port = htons(8080);
		sin_addr.s_addr = INADDR_ANY;
	} address;

	int server_fd, new_socket;
	int opt = 1;
	int addrlen = sizeof(address);

	char buffer[1024] = {0};


	// 1. Create socket file descriptor
	server_fd = socket(AF_INET, SOCK_STREAM, 0);
	if (server_fd == 0) {
		perror("socket failed");
		exit(EXIT_FAILURE);
	}

	// 2. Set options for the socket
	setsockopt(server_fd, SOL_SOCKET, SO_REUSEADDR | SO_REUSEPORT, &opt, sizeof(opt));

	// 4. Bind the socket to the address
	if (bind(server_fd, (struct sockaddr *)&address, sizeof(address)) < 0) {
		perror("bind failed");
		exit(EXIT_FAILURE);
	}

	// 5. Start listening for connections
	listen(server_fd, 3);

	printf("Waiting for a connection...\n");

	// 6. Accept a connection
	new_socket = accept(server_fd, (struct sockaddr *)&address, (socklen_t*)&addrlen);
	if (new_socket < 0) {
		perror("accept");
		exit(EXIT_FAILURE);
	}

	// 7. Read from client
	read(new_socket, buffer, 1024);
	printf("Message from client: %s\n", buffer);

	// 8. Send response
	send(new_socket, "Hello from server", strlen("Hello from server"), 0);
	printf("Hello message sent\n");

	// 9. Clean up
	close(new_socket);
	close(server_fd);
	return 0;
}
