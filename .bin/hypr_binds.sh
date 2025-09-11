#!/bin/bash

launch_terminal() {
    if [[ $(hyprctl activeworkspace | grep "workspace ID 1 ") ]]; then
        hyprctl dispatch -- exec ghostty --gtk-single-instance=true
    elif [[ $(hyprctl clients | grep "com.mitchellh.ghostty") ]]; then
        hyprctl dispatch workspace 1
    else
        hyprctl dispatch -- exec ghostty --gtk-single-instance=true
    fi
}

launch_browser() {
    if [[ $(hyprctl activeworkspace | grep "workspace ID 2 ") ]]; then
        hyprctl dispatch exec librewolf
    elif [[ $(hyprctl clients | grep "librewolf") ]]; then
        hyprctl dispatch workspace 2
    else
        hyprctl dispatch exec librewolf
    fi
}

launch_files() {
    if [[ $(hyprctl activeworkspace | grep "workspace ID 3 ") ]]; then
        hyprctl dispatch exec thunar
    elif [[ $(hyprctl clients | grep "thunar") ]]; then
        hyprctl dispatch workspace 3
    else
        hyprctl dispatch exec thunar
    fi
}

$1
