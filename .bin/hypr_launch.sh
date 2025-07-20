#!/bin/bash

launch_terminal() {
    if [[ $(hyprctl activeworkspace | grep "workspace ID 1 ") ]]; then
        hyprctl dispatch -- exec ghostty --gtk-single-instance=true
    else
        hyprctl dispatch workspace 1
    fi
}

launch_browser() {
    if [[ $(hyprctl activeworkspace | grep "workspace ID 2 ") ]]; then
        hyprctl dispatch exec librewolf
    else
        hyprctl dispatch workspace 2
    fi
}

$1
