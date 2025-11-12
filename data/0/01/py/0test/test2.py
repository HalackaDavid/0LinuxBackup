from threading import Thread
import pyautogui
from pynput.keyboard import Key, Controller
import ctypes
import keyboard
import time
import random
import platform
import os
from time import sleep

menu_opt = '''
Menu
=====================================
[1] Write Sentences
[2] Write Letters
[3] Write Backwards
[4] Write until time ends (not ready)
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

Os = platform.system()
def clear():
    if Os == "Linux":
        os.system("clear")
    if Os == "Windows":
        os.system("cls")

#===================================================
def timer():
    t1 = 0
    t2 = 10
    t3 = t1*60 + t2
    print(t3 - 1)
    t = 0 
    while t < t3:
        time.sleep(1)
        print(t, end="\r" )
        t += 1

def start_counter():
    number = 1
    number1 = 3
    while number in range(4):
        print(number1)
        time.sleep(1)
        number += 1
        number1 -= 1

def Writer(text, mode):
    for letter in text:
        digit = 6
        if mode == "1":
            fl = round(random.uniform(0,0), digit)#godmode 0.07, 0.18
        if mode == "2":
            fl = round(random.uniform(0.1, 0.2), digit)#fast 0.1 0.11 
        if mode == "3":
            fl = round(random.uniform(0.1, 0.3), digit)#normal
        if mode == "4":
            fl = round(random.uniform(0.2, 0.4), digit)#slow
        print(fl)
        time.sleep(fl)
        keyboard.write(letter)

def WS(text, mode):
    clear()
    Writer(text, mode)

def WL(text, mode):
    for letter in text:
        if letter != " ":
            text = letter
            Writer(text, mode)

def WB():
    pass

def WUTE():
    pass

def reverse_slicing(s):
    return s[::-1]

def menu(mode):
    clear()
    usri = input(menu_opt)
    if usri == "1":
        repeater = int(input("repeat: "))
        text = input("text: ")
        start_counter()
        rep = 1
        for rep in range(1, repeater +1):
            if rep == repeater:
                WS(text, mode)
            else:
                WS(text, mode)
                keyboard.press("Enter")
        menu(mode)
    if usri == "2":
        text = input("text: ")
        start_counter()
        WL(text, mode)
        menu(mode)
    if usri == "3":
        usri_str = input("text: ")
        text = usri_str + "\n" + reverse_slicing(usri_str)
        start_counter()
        Writer(text, mode)
        menu(mode)
    if usri == "4":
        text = input("text: ")
        t = int(input("time: "))
        start_counter()
        t_end = time.time() + t -1
        while time.time() < t_end:
            Writer(text, mode)
        
        
    if usri == 'b':
        speed()

def speed():
    clear()
    mode = input(speed_opt)
    menu(mode)

speed()