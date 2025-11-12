import json
import socket
host = socket.gethostname()
ip = socket.gethostbyname(host)
j1 = "j1.json"
with open(j1, "r") as f1:
    j = json.load(f1)
    for s in j["ip"]:
        if s == ip:
            print("\nAccess allowed")
