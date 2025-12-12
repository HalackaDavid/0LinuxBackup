import sys
import os
import socket
import whatismyip

arr=[]
i = 2
if os.path.exists(sys.argv[1]):
    os.remove(sys.argv[1])
try:
    while sys.argv[i]:
        match sys.argv[i]:
            case "hostname":
                s = socket.gethostname()
            case "public_ip":
                s = "127.0.0.1"
            case _:
                s = "NONE"
        arr.append(f"\"{sys.argv[i]}\":\"{s}\"")
        i += 1
except IndexError:
    pass

for x in arr:
    with open(sys.argv[1], "a") as file:
        file.write(f"{x}\n")




"""
import platform,socket

def getSystemInfo():
    try:
        info={}
        info['platform']=platform.system()
        info['platform-release']=platform.release()
        info['platform-version']=platform.version()
        info['architecture']=platform.machine()
        info['hostname']=socket.gethostname()
        info['ip-address']=socket.gethostbyname(socket.gethostname())
        print(info["hostname"])
    except None:
        print("fuck")

"""

"""
import whatismyip
print("online")
o=whatismyip.amionline()
print(o)
print("ip4")
ip4=whatismyip.whatismyipv4()
print(ip4)
print("ip6")
ip6=whatismyip.whatismyipv6()
print(ip6)


        platform.system()
        platform.release()

        platform.version()

        platform.machine()

        socket.gethostname()

s        socket.gethostbyname(socket.gethostname())
"""
