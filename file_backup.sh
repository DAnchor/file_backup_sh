#!/bin/bash

export func=()
{
if python3 << P3 > /dev/null 2>&1
P3
then
    PYTHON=python3
    echo Successfully set Python3 variable
else
    PYTHON=none
    echo Failed to set Python3 variable
    return 1
fi
$PYTHON <<EOF
import os
import pathlib
import shutil
import zipfile


# adding directories and files
def creating_files():
    my_dir = os.getcwd()
    pathlib.Path(str(my_dir) + '/backup').mkdir(parents=True, exist_ok=True)
    pathlib.Path(str(my_dir) + '/working').mkdir(parents=True, exist_ok=True)
    pathlib.Path(str(my_dir) + '/working/pics').mkdir(parents=True, exist_ok=True)
    pathlib.Path(str(my_dir) + '/working/docs').mkdir(parents=True, exist_ok=True)
    pathlib.Path(str(my_dir) + '/working/docs/school').mkdir(parents=True, exist_ok=True)
    pathlib.Path(str(my_dir) + '/working/docs/party').mkdir(parents=True, exist_ok=True)
    pathlib.Path(str(my_dir) + '/working/movie').mkdir(parents=True, exist_ok=True)
    open(str(my_dir) + "/working/docs/" + "traceF.txt", "w+")
    open(str(my_dir) + "/working/docs/" + "backM.txt", "w+")
    open(str(my_dir) + "/working/docs/" + "crazyS.txt", "w+")
    open(str(my_dir) + "/working/docs/" + "dragonQ.txt", "w+")
    open(str(my_dir) + "/working/docs/" + "fireThem.txt", "w+")


# renaming files in "working/docs/"
def rename_file_prefix():
    list_files = os.getcwd()+str("/working/docs/")
    os.chdir(list_files)
    for filename in os.listdir(list_files):
        if filename.endswith(".txt"):
            os.rename(filename, filename.replace(filename, filename[:-3].upper() + "txt"))


# zip archive
def archive():
    src = os.getcwd() + str("/working/docs/")
    dst = os.getcwd() + str("/backup/")
    os.chdir(dst)
    with zipfile.ZipFile("docs.zip", "w", zipfile.ZIP_DEFLATED) as zf:
        abs_src = os.path.abspath(src)
        for dirname, subdirs, files in os.walk(src):
            for filename in files:
                absname = os.path.abspath(os.path.join(dirname, filename))
                arcname = absname[len(abs_src) + 1:]
                zf.write(absname, arcname)
    zip("src", "dst")
    os.chdir(dst)
    shutil.copyfile("docs.zip", "docs2.zip")
    shutil.copyfile("docs.zip", "docs3.zip")
    print("\ndocs.zip contains:")
    with zipfile.ZipFile("docs.zip", "r") as zfr:
        for name in zfr.namelist():
            print(name, end=", ")
    print("\n/backup folder contents:\n" + str(os.listdir(dst)))
    zf.close()
    zfr.close()


# delete all directories and files
def delete_directory_and_files():
    list_files = os.listdir(os.getcwd())
    for filename in list_files:
        if not filename.endswith(".sh"):
            os.removedirs(filename)
            shutil.rmtree(filename)


def main():
    #delete_directory_and_files()
    #creating_files()
    #rename_file_prefix()
    #archive()
    pass


# executing main
if __name__ == "__main__":  
    main()
EOF
}
