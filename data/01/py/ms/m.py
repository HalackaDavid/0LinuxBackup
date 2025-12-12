import socket

def main():

    # Define the slave's IP address and port
    slave_ip = '192.168.10.114'  # Replace with the actual IP address of the slave
    slave_port = 666      # Replace with the port number the slave is listening on

    # Create a socket to communicate with the slave
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.connect((slave_ip, slave_port))

    task = input("input: ")

    sock.sendall(str(task).encode())
    result = sock.recv(1024).decode()
    print("Task:", task, "Result:", result)

    # Close the socket
    sock.close()

    main()

main()
