#! /usr/bin/env python3

new_line = "This line is simple text to append.\n"

# Open the file in append mode ('a')
with open("./public/simple.txt", "a") as f:
    # Write the new text to the end of the file
    f.write(new_line)

