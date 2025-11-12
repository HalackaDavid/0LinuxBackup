import socket, requests, platform, os

HOST = socket.gethostname()
IP = socket.gethostbyname(HOST)
EMAIL = "KUNDA33@gmail.com"

Os = platform.system()
def clear():
    if Os == "Linux":
        os.system("clear")
    if Os == "Windows":
        os.system("cls")

def Login():
    clear()
    #l = "1234567abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    l = f"{HOST}{IP}{EMAIL}"
    with open("login.txt", "r") as ftxt1:
        datatxt = ftxt1.readline()
    fjson1 = requests.get("http://xxx.kvalitne.cz/1.json")
    datajson1 = fjson1.json()
    for i in l:
        for i2 in datajson1["BTT"]:
            x = i2[i]
            print(x[3])

    """     for i1 in datajson1[datatxt]:
        for i11 in i1["ho"]:
            if HOST == i11:
                print(f"T-HO {i11}")
            else:
                print(f"F-HO {i11}")
        print()
    for i2 in datajson1[datatxt]:
        for i22 in i2["ip"]:
            if IP == i22:
                print(f"T-IP {i22}")
            else:
                print(f"F-IP {i22}") """
    
    fjson1.close()

clear()
Login()