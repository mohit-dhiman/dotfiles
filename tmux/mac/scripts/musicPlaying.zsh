#!/bin/zsh
np=""
state=$(osascript -e 'tell application "Music" to get player state')
if [[ $state == "playing" ]]; then
	track=$(osascript -e 'tell application "Music" to get name of the current track')
	artist=$(osascript -e 'tell application "Music" to get artist of the current track')
	if [ ${#artist} -gt 15 ]
	then
		artist=${artist:0:12}"..."
	fi
	np=$(echo "${artist} - ${track}")
	if [ ${#np} -gt 35 ]
	then
		np=${np:0:32}"..."
	fi
fi
echo "$np"
