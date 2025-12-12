import requests
fjson1 = requests.get("http://xxx.kvalitne.cz/2.json")
datajson1 = fjson1.json()
for i in datajson1["ip"]:
    if i == 666:
        print("num")
    else:
        print(i)
fjson1.close()
