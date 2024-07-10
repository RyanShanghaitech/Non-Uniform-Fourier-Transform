import os.path as path
import subprocess as sp
import atexit

dirThisFile, nameThisFile = path.split(__file__)
process = sp.Popen(path.join(dirThisFile, "NudftServer/build/NudftServer"))

def cleanup():
    global process
    process.terminate()

atexit.register(cleanup)