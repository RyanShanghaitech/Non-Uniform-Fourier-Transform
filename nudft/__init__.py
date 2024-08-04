from .NudftClient import NudftClient

# register cleanup at exit
import os.path as path
import subprocess as sp
import atexit
import time

dirThisFile, nameThisFile = path.split(__file__)
process = sp.Popen(path.join(dirThisFile, "NudftServer/build/NudftServer"))
atexit.register(lambda: process.terminate())
time.sleep(500e-3) # sleep for a while to let the server start
