import socket
def Login():
    HOST = socket.gethostname()
    IP = socket.gethostbyname(HOST)

    print(HOST, IP)
    ho1 = "DESKTOP-B1CIAM8"
    ip1 = "172.23.144.1"

    ho2 = ""
    ip2 = ""

    if HOST != ho1:
        print("IP Error")
        Hoster = False
    else:
        Hoster = True

    if IP != ip1:
        print("Host Error")
        Iper = False
    else:
        Iper = True

    if Hoster == True and Iper == True:
        print("Welcome")
    else:
        print("Error")

Login()
