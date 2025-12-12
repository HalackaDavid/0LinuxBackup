import pyautogui
from pynput.keyboard import Key, Controller
import ctypes
import keyboard
import time
import random
import platform
import os
import json
import socket
import requests

errormessage = "\nMake sure code was in correct format and you are on same pc. If the problem will continue to occur, please call administrator.\n"

menu_opt = '''
Menu
=====================================
[1] Write Sentences
[2] Write Letters
[3] Write Backwards
[4] Write until time ends
[b] Speed Mode
Option: '''

speed_opt = '''
Speed Mode
===========
[1] godmode
[2] fast
[3] normal
[4] slow
Speed Mode: '''

time_opt = '''
[600] for 10 mins
[300] for 5 minss
time (in sec): '''

HOST = socket.gethostname()
IP = socket.gethostbyname(HOST)

Os = platform.system()
def clear():
    if Os == "Linux":
        os.system("clear")
    if Os == "Windows":
        os.system("cls")

digit = 6
dev1, dev2 = 0, 0
godmode1, godmode2 = 0.07, 0.18
fast1, fast2 = 0.1, 0.2
normal1, normal2= 0.1, 0.3
slow1, slow2 = 0.2, 0.4
#===================================================
def Developer(fl, DEV):
    if DEV == True:
        print(fl)
    else:
        print("Running...")

def start_counter():
    clear()
    number = 1
    number1 = 3
    while number in range(4):
        print(number1)
        time.sleep(1)
        number += 1
        number1 -= 1

def Writer(text, mode, DEV):
    for letter in text:
        if mode == "dev":
            fl = round(random.uniform(dev1, dev2), digit)
        if mode == "1":
            fl = round(random.uniform(godmode1, godmode2), digit)
        if mode == "2":
            fl = round(random.uniform(fast1, fast2), digit) 
        if mode == "3":
            fl = round(random.uniform(normal1, normal2), digit)
        if mode == "4":
            fl = round(random.uniform(slow1, slow2), digit)
        Developer(fl, DEV)
        time.sleep(fl)
        keyboard.write(letter)

def WriterT(text, mode, t, DEV):
    t_end = time.time() + t -1
    while time.time() < t_end:
        for letter in text:
            if mode == "dev":
                fl = round(random.uniform(dev1, dev2), digit)
            if mode == "1":
                fl = round(random.uniform(godmode1, godmode2), digit)
            if mode == "2":
                fl = round(random.uniform(fast1, fast2), digit) 
            if mode == "3":
                fl = round(random.uniform(normal1, normal2), digit)
            if mode == "4":
                fl = round(random.uniform(slow1, slow2), digit)
            if time.time() < t_end:
                Developer(fl, DEV)
                time.sleep(fl)
                keyboard.write(letter)
        keyboard.press("Enter")
            
def reverse_slicing(s):
    return s[::-1]

def menu(mode, DEV):
    clear()
    usri = input(menu_opt)
    if usri == "1":
        repeater = int(input("repeat: "))
        text = input("text: ")
        start_counter()
        clear()
        rep = 1
        for rep in range(1, repeater +1):
            if rep == repeater:
                Writer(text, mode, DEV)
            else:
                Writer(text, mode, DEV)
                keyboard.press("Enter")
        menu(mode, DEV)

    if usri == "2":
        text = input("text: ")
        start_counter()
        clear()
        for letter in text:
            if letter != " ":
                text = letter
                Writer(text, mode, DEV)
        menu(mode, DEV)

    if usri == "3":
        usri_str = input("text: ")
        text = usri_str + "\n" + reverse_slicing(usri_str)
        start_counter()
        clear()
        Writer(text, mode, DEV)
        menu(mode, DEV)

    if usri == "4":
        text = input("text: ")
        t = float(input(time_opt))
        start_counter()
        clear()
        WriterT(text, mode, t, DEV)
        menu(mode, DEV)

    if usri == "b":
        speed(DEV)

    if usri is not {"1","2","3","4","b"}:
        menu(mode, DEV)

def speed(DEV):
    clear()
    mode = input(speed_opt)
    if DEV == True and mode == "dev":
        menu(mode, DEV)
    if mode == "1":
        menu(mode, DEV)
    if mode == "2":
        menu(mode, DEV)
    if mode == "3":
        menu(mode, DEV)
    if mode == "4":
        menu(mode, DEV)
    if mode is not {"1","2","3","4","b","dev"}:
        speed(DEV)

def Decoder():
    print(HOST, IP)

def log1():
    try:
        with open("login.txt", "r") as ftxt1:
            datatxt = ftxt1.readline()
        if os.stat("login.txt").st_size <= 3:
            x = input("Please enter your code: ")
            with open("login.txt", "w") as ftxt1:
                if len(x) > 3:
                    ftxt1.write(x)
                    ftxt1.close()
                    Login()
                elif len(x) <= 3:
                    clear()
                    print("Not long enough")
                    log1()
        
        elif datatxt == "NEW_USER":
            Decoder()
        else:
            Login()
    except KeyboardInterrupt:
        pass
    except FileNotFoundError:
        x = input("Please enter your code: ")
        with open("login.txt", "w") as ftxt1:
            if len(x) > 3:
                ftxt1.write(x)
                ftxt1.close()
                Login()
            else:
                clear()
                print("Not long enough")
                log1()

def Login():
    clear()
    try:
        with open("login.txt", "r") as ftxt1:
            datatxt = ftxt1.readline()
        
        fjson1 = requests.get("http://xxx.kvalitne.cz/1.json")
        datajson1 = fjson1.json()
        for i in datajson1[datatxt]:
            pass
        fjson1.close()

        for i1 in datajson1[datatxt]:
            for i11 in i1["ho"]:
                if HOST == i11:
                    print(f"T-HO {i11}")
                    H = True
                    break
                else:
                    print(f"F-HO {i11}")
                    H = False

        for i2 in datajson1[datatxt]:
            for i22 in i2["ip"]:
                if IP == i22:
                    print(f"T-IP {i22}")
                    I = True
                    break
                else:
                    print(f"F-IP {i22}")
                    I = False

        if "1" == i["DEV"]:
            DEV = True
        else:
            DEV = False

        if I == True and H == True:
            speed(DEV)
        else:
            print("errormessage" + " Error Code xgl1")#host or ip error
    except KeyboardInterrupt:
        pass
    except:
        print(errormessage)
        with open("login.txt", "w") as ftxt1:
            ftxt1.write("")
            ftxt1.close()
            log1()
clear()
log1()