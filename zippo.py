import shutil
import os


def zipo(directory=str(input("Enter directory: ")), CustomOutput=False):
    dirlist = [item for item in os.listdir(directory) if os.path.isdir(os.path.join(directory, item))]
    for i in dirlist:
        a = str(directory + "\\" + i)
        if CustomOutput == False:
            shutil.make_archive(a, 'zip', a)
        else:
            a = str(directory + "\\" + i)
            i = str(CustomOutput + "\\" + i)
            shutil.make_archive(i, 'zip', a)

zipo()