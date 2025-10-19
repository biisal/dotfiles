#!/bin/bash

APPS=(
    com.google.android.apps.youtube.music
    com.google.android.videos
    com.google.android.apps.safetyhub
	com.xiaomi.mipicks
	com.xiaomi.glgm
)
RED="\033[31m"
NC="\033[0m"
GREEEN="\033[32m"
BLUE="\033[34m"

echo "What do you want Install[i], Uninstall[u], abort[a] ?"
read answer

case "$answer" in
	"i" | "I" ) 
	for pkg in "${APPS[@]}"; do
		echo -e "${BLUE}Installing $pkg ...${NC}"
		adb shell cmd package install-existing "$pkg"
	done
		;;
	"u" | "U" ) 
	for pkg in "${APPS[@]}"; do
		echo -e "${GREEEN}Uninstalling $pkg ...${NC}"
		adb shell pm uninstall -k --user 0 "$pkg"
	done;;
	"a" | "A" ) echo "Aborted";;
	* ) echo -e "${RED}Invalid input${NC}";;
esac

