#! /usr/bin/env python3
import sys
import time
import os

minCounter = 0
maxCountEnv = int(os.environ.get("maxCountEnv"))
maxCounter = maxCountEnv if maxCountEnv and maxCountEnv > 0 and maxCountEnv < 50 else 1

file_path = "./public/simple.txt"


def getLastLineNumber(filename):
    with open(filename, "r") as file:
        lines = file.readlines()
        # The length of the list is the total number of lines
        return len(lines)


while minCounter < maxCounter:
    new_line = (
        f"{getLastLineNumber(file_path) + 1}: This line is simple text to append.\n"
    )
    # Open the file in append mode ('a')
    with open(file_path, "a") as f:
        # Write the new text to the end of the file
        f.write(new_line)
    time.sleep(1)
    minCounter = minCounter + 1
    print(f"entrypoint.py still running! minCounter:{minCounter} maxCounter: {maxCounter}")
