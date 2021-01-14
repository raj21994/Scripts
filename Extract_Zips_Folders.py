import os
import zipfile

def unzip(directory=str(input("Enter directory: "))):
    dirlist = [zips for zips in os.listdir(directory) if zips.endswith('.zip')]
    print('\n'.join(map(str, dirlist)))
    for i in dirlist:
        x = str(directory + '\\' + i)
        extract = zipfile.ZipFile(x)
        extract.extractall(x[:-4])

unzip()