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
def start_counter():
    clear()
    number = 1
    number1 = 3
    while number in range(4):
        print(number1)
        time.sleep(1)
        number += 1
        number1 -= 1

def Writer(text, mode):
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
        print(fl)
        time.sleep(fl)
        keyboard.write(letter)

def WriterT(text, mode, t):
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
                print(fl)
                time.sleep(fl)
                keyboard.write(letter)
        keyboard.press("Enter")
            
def reverse_slicing(s):
    return s[::-1]

def menu(mode):
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
                Writer(text, mode)
            else:
                Writer(text, mode)
                keyboard.press("Enter")
        menu(mode)

    if usri == "2":
        text = input("text: ")
        start_counter()
        clear()
        for letter in text:
            if letter != " ":
                text = letter
                Writer(text, mode)
        menu(mode)

    if usri == "3":
        usri_str = input("text: ")
        text = usri_str + "\n" + reverse_slicing(usri_str)
        start_counter()
        clear()
        Writer(text, mode)
        menu(mode)

    if usri == "4":
        text = input("text: ")
        t = float(input(time_opt))
        start_counter()
        clear()
        WriterT(text, mode, t)
        menu(mode)

    if usri == "b":
        speed()

    if usri is not {"1","2","3","4","b"}:
        menu(mode)

def speed():
    clear()
    mode = input(speed_opt)
    if mode == "dev":
        menu(mode)
    if mode == "1":
        menu(mode)
    if mode == "2":
        menu(mode)
    if mode == "3":
        menu(mode)
    if mode == "4":
        menu(mode)
    if mode is not {"1","2","3","4","b","dev"}:
        speed()

speed()