tkr = input("text: ")

with open("decoded.txt", "w") as wrt:
    for e in tkr:
        res = ''.join(format(ord(i), '08b')for i in e)
        wrt.write(e + " = " +str(res) + "\n")

wrt.close()