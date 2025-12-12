i0 = "ab" #0 110000
i1 = "zs" #1 110001
i2 = "xh" #2 110010
i3 = "wy" #3 110011
i4 = "jf" #4 110100
i5 = "qg" #5 110101
i6 = "lv" #6 110110
i7 = "ke" #7 110111
i8 = "po" #8 111000
i9 = "dc" #9 111001
i10 = "ttx" #. 101110
i101 = "_"
fe1 = open("encode.txt", "r")
fe2 = open("encoded.txt", "w")
encode = fe1.read()
for e in encode:
    match e:
        case "0":
            fe2.writelines(i0)
        case "1":
            fe2.writelines(i1)
        case "2":
            fe2.writelines(i2)
        case "3":
            fe2.writelines(i3)
        case "4":
            fe2.writelines(i4)
        case "5":
            fe2.writelines(i5)
        case "6":
            fe2.writelines(i6) 
        case "7":
            fe2.writelines(i7)
        case "8":
            fe2.writelines(i8)      
        case "9":
            fe2.writelines(i9)
        case ".":
            fe2.writelines(i10)
        case " ":
            fe2.writelines(i101)
fe1.close()
fe2.close()
""" fd1 = open("decode.txt", "w")
fd2 = open("decoded.txt", "r")
decode = fd1.read()
for d in decode:
    match d:
        case "": 

fd1.close()
fd2.close()"""