#!/bin/bash

# ADE - Android Desktop Experience
# Script to use Android as Full Desktop Environment on laptop

default_density=$(adb shell wm density | grep -o '[0-9]*')
new_density="180"
# Changing display density of android device
echo "Default display density is >> [ $default_density ]"
echo "Changing display density from $default_density >  to >  $new_density..."
adb shell wm density $new_density

default_keyboard=$(adb shell settings get secure default_input_method)
echo "Default Input method is >> [ $default_keyboard ]"

# Switching to Null Keyboard.
null_keyboard="com.wparam.nullkeyboard/.NullKeyboard"
echo "Switching to Null Keyboard.."
adb shell settings put secure default_input_method $null_keyboard

# Rotating Screen
default_rotation=$(adb shell settings get system user_rotation)
echo "Rotating screen to landscape..."
adb shell settings put system user_rotation 1

# Starting ScrCpy for view device on fullscreen
echo "Starting ScrCpy in Fullscreen mode..."
scrcpy --fullscreen --turn-screen-off 

# Once the scrcpy stops
# Changing the device density to default

echo "Scrcpy Stopped..."
echo "Changing pixel density from $new_density to $default_density.."
adb shell wm density $default_density
   
echo "Switching to default Keyboard.."
adb shell settings put secure default_input_method $default_keyboard 

echo "Rotating screen to portrait..."
adb shell settings put system user_rotation $default_rotation


# -----------------------
