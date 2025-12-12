import time
#1 check database
#2 

all = "100%" #procentage of everything
itmnm = ["cd", "ls","dpkg"] #item name
itmdwn = ["666.0 KB/666.0 KB","666.0 MB/666.0 MB","666.0 GB/666.0 GB"] #package size
itmdwnr = ["15mb/s","15mb/s","15mb/s"] #Download rate 
#print(f"{all} [{itmnm} | {itmdwn} | {itmdwnr}]") #100% [item name | 1/100 | 666.0 MB/666.0 MB | 5mb/s]

def nextitem(items):
    yield from items
loopover0 = nextitem(itmnm)
loopover1 = nextitem(itmdwn)
loopover2 = nextitem(itmdwnr)
while True:
    try:
        print(f"{all} [ {next(loopover0)} | {next(loopover1)} | {next(loopover2)}]", end="\r")
        time.sleep(1)
    except StopIteration:
        break