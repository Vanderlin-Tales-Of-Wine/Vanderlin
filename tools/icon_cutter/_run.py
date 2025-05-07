import platform
import subprocess
import os

path_to_us = os.path.realpath(os.path.dirname(__file__))

template = f"{path_to_us}\\templates"
turf = f"{path_to_us}\\..\\..\\icons\\turf\\smooth"
obj = f"{path_to_us}\\..\\..\\icons\\obj\\smooth_structures"
path = f"{path_to_us}\\hypnagogic.exe -t {template} {turf} {obj}"

if platform.system() == "Windows":
    subprocess.run(f"{path}", shell = True)
else:
    path = path.replace("\\", "/")
    subprocess.run(f"{path}", shell = True)
