import os 

hostname = "kali"
Dt = "1"
def getData1():
    print("Getting....")
    while (1):    
        try:
            f = open(f"data/{hostname}.txt", "x")
            f.write(Dt)
            f.close
        except FileExistsError:
            dir_path = "data"
            count = 0
            for path in os.listdir(dir_path):
                if os.path.isfile(os.path.join(dir_path, path)):
                    count += 1
            print('File count:', count)

            file_path = f'data/kali_{count}.txt'
            print(file_path)
            f = open(file_path, "x")
            f.write(Dt)
            f.close
getData1()