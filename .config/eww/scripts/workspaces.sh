#!/bin/bash

icons=(1 2 3 4 5 6 7 8 9 10 A)

update_workspace(){
    icons_index=(0 1 2 3 4 5 6 7 8 9)
    icons_index[$(($1 -1))]="10"
    ret_str="(box (label :text \"${icons[${icons_index[0]}]} ${icons[${icons_index[1]}]} ${icons[icons_index[2]]} ${icons[icons_index[3]]} ${icons[icons_index[4]]} ${icons[icons_index[5]]} ${icons[icons_index[6]]} ${icons[icons_index[7]]} ${icons[icons_index[8]]} ${icons[icons_index[9]]}\" ))"
    echo "${ret_str}"
}

treat_event(){
    if [[ ${1:0:9} == "workspace" ]]; then
        workspace_num="${1:(-1)}"
        if [[ ${workspace_num} == 0 ]]; then
            workspace_num="${1:(-2):2}"
        fi
        if [[ workspace_num -gt 9 ]]; then
            workspace_num=1
            hyprctl dispatch workspace 1 >/dev/null
        fi
    update_workspace $workspace_num
    fi
}


socat -s UNIX-CONNECT:/tmp/hypr/"$HYPRLAND_INSTANCE_SIGNATURE"/.socket2.sock - | while read line; do treat_event $line; done