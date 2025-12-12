str=input("text: ")
str_encoded=str.encode('utf_16','strict')
str_decoded=str_encoded.decode('utf_16', 'strict')
print("Encode: ", str_encoded, "\nDecode: ", str_decoded)
