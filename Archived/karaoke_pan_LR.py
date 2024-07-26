#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""Tests the audacity pipe.

Keep pipe_test.py short!!
You can make more complicated longer tests to test other functionality
or to generate screenshots etc in other scripts.

Make sure Audacity is running first and that mod-script-pipe is enabled
before running this script.

Requires Python 2.7 or later. Python 3 is strongly recommended.

"""

import os, glob
import sys
import subprocess
from contextlib import contextmanager

if sys.platform == 'win32':
    print("pipe-test.py, running on windows")
    TONAME = '\\\\.\\pipe\\ToSrvPipe'
    FROMNAME = '\\\\.\\pipe\\FromSrvPipe'
    EOL = '\r\n\0'
else:
    print("pipe-test.py, running on linux or mac")
    TONAME = '/tmp/audacity_script_pipe.to.' + str(os.getuid())
    FROMNAME = '/tmp/audacity_script_pipe.from.' + str(os.getuid())
    EOL = '\n'

print("Write to  \"" + TONAME +"\"")
if not os.path.exists(TONAME):
    print(" ..does not exist.  Ensure Audacity is running with mod-script-pipe.")
    sys.exit()

print("Read from \"" + FROMNAME +"\"")
if not os.path.exists(FROMNAME):
    print(" ..does not exist.  Ensure Audacity is running with mod-script-pipe.")
    sys.exit()

print("-- Both pipes exist.  Good.")

TOFILE = open(os.path.normpath(TONAME), 'w', encoding="utf-8")
print("-- File to write to has been opened")
FROMFILE = open(os.path.normpath(FROMNAME), 'rt')
print("-- File to read from has now been opened too\r\n")


def send_command(command):
    """Send a single command."""
    print("Send: >>> \n"+command)
    TOFILE.write(command + EOL)
    TOFILE.flush()

def get_response():
    """Return the command response."""
    result = ''
    line = ''
    while True:
        result += line
        line = FROMFILE.readline()
        if line == '\n' and len(result) > 0:
            break
    return result

def do_command(command):
    """Send one command, and return the response."""
    send_command(command)
    response = get_response()
    print("Rcvd: <<< \n" + response)
    return response

@contextmanager
def working_directory(directory):
    owd = os.getcwd()
    try:
        os.chdir(directory)
        yield directory
    finally:
        os.chdir(owd)

def run():
    n = len(sys.argv)
    
    if n <= 1:
        return
    
    folder_path = sys.argv[1]
    audio_files = []
    
    #Get audio tracks
    for file in glob.glob("*.m4a", root_dir=folder_path):
        audio_files.append(file)
        
    for file in glob.glob("*.opus", root_dir=folder_path):
        audio_files.append(file)
    
    karaoke_audio_files = []
    karaoke_audio_folder_path = folder_path + "\\separated\\"
    
    for file in glob.glob("**/*.mp3", root_dir=karaoke_audio_folder_path, recursive=True):
        karaoke_audio_files.append(file)
    
    karaoke_audio_path =  karaoke_audio_folder_path + karaoke_audio_files[0]
    audio_path = folder_path + "\\" + audio_files[0]
    
    #subprocess.run(["ffmpeg", "-i", audio_path, "-c:v", "copy", "-c:a", "libmp3lame","-q:a", "4", "audio.mp3"], cwd=folder_path) 
    
    track_2 = '"' + audio_path + '"'
    import_original_command = f"Import2: Filename={track_2}"
    do_command(import_original_command)
    
    for i in range(0, 10):
        do_command('TrackPanLeft')

    track_1 = '"' + karaoke_audio_path + '"'
    import_no_vocals_command = f"Import2: Filename={track_1}"
    do_command(import_no_vocals_command)
    
    for i in range(0, 10):
        do_command('TrackPanRight')
    
    export_path = '"' + folder_path + "\\karaoke.ac3" + '"'
    export_command = f"Export2: Filename={export_path} NumChannels=2"
    do_command("SelAllTracks")
    do_command(export_command)
    
    # project_path = '"' + folder_path + "\\project.aup3" + '"'
    # do_command(f"SaveProject2: Filename={project_path}")
    
    do_command("Exit")

run()
