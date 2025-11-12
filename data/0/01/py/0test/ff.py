import json
import socket
host = socket.gethostname()
ip = socket.gethostbyname(host)
j1 = "j1.json"
j2 = "j2.json"

with open(j1, "r") as f1:
    j1 = json.load(f1)

with open(j2, "r") as f2:
    j2 = json.load(f2)

print(f"{j1}\n{j2}")
ls1 = len(str(j1))
ls2 = len(str(j2))

if ls1 < ls2:
    print("="*ls2)
elif ls2 < ls1:
    print("="*ls1)
elif ls1 == ls2:
    print("="*ls1)

if j1 == j2:
    print("same")
elif j1 != j2:
    print("not same")

l = j1["ip"] + j2["ip"]

nl = list(dict.fromkeys(l).keys())

print("Parsed list: ", nl)
