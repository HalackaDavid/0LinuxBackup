import socket
import sys
import os

def main():
    # Define the listening IP address and port for the slave
    slave_ip = '192.168.10.114'
    #slave_ip = '172.23.144.1'
    slave_port = 666

    # Create a socket to listen for incoming connections
    server_sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_sock.bind((slave_ip, slave_port))
    server_sock.listen(1)

    print("Slave is waiting for a connection...")

    # Accept a connection from the master
    client_sock, client_addr = server_sock.accept()
    print("Connected to", client_addr)

    while True:
        task = client_sock.recv(1024).decode()
        if task == "exit":
            print(" ")
            print("exit")
            print(" ")
            #sys.exit()
        if task == "ls":
            os.system("dir")
        if not task:
            break

        # Perform some work (in this case, doubling the task)
        result = str(task)

        # Send the result back to the master
        client_sock.sendall(result.encode())

    # Close the sockets
    client_sock.close()
    server_sock.close()
    main()
main()