import json

j1 = "passwd.json"
n = "wifi passwords"
with open(j1, "r") as f1:
    j1p = json.load(f1)
    print(json.dumps(j1p, indent=4))
