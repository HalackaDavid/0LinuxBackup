import socket
HOST = socket.gethostname()
IP = socket.gethostbyname(HOST)

print(HOST, IP)