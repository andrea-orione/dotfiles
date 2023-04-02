#!/usr/python

import subprocess
import os
import socket

icons = ["", "", "", "", "", "", "", "", "", "", ""]

def update_workspace(current_workspace):
    icons_index=[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    icons_index[current_workspace-1]=10
    prompt = f"(box (label :class \"workspaces\" :text \"{icons[icons_index[0]]} {icons[icons_index[1]]} {icons[icons_index[2]]} {icons[icons_index[3]]} {icons[icons_index[4]]} {icons[icons_index[5]]} {icons[icons_index[6]]} {icons[icons_index[7]]} {icons[icons_index[8]]} {icons[icons_index[9]]}\" ))"
    subprocess.run(f"echo '{prompt}'", shell=True)

sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)

server_address = f'/tmp/hypr/{os.environ["HYPRLAND_INSTANCE_SIGNATURE"]}/.socket2.sock'

sock.connect(server_address)

while True:
    new_event = sock.recv(4096).decode("utf-8")

    for item in new_event.split("\n"):
        if item[0:11] == "workspace>>":
            workspaces_num = int(item[11:])

            if workspaces_num > 10:
                workspaces_num = 1
                subprocess.run("hyprctl dispatch workspace 1 > /dev/null", shell=True)

            update_workspace(workspaces_num)
