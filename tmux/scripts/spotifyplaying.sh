#!/bin/bash
user=$(ps aux | grep spotify |grep -v "grep\|spotifyplaying" |head -1|awk '{print $1}')
np=""
metadata=$(su $user -c "dbus-send --reply-timeout=42 --print-reply --session --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata' 2>/dev/null")
if [ "$?" -eq 0 ] && [ -n "$metadata" ]; then
    state=$(su $user -c "qdbus org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get org.mpris.MediaPlayer2.Player PlaybackStatus")
    if [[ $state == "Playing" ]]; then
        artist=$(echo "$metadata" | grep -PA2 "string\s\"xesam:artist\"" | tail -1 | grep -Po "(?<=\").*(?=\")")
        track=$(echo "$metadata" | grep -PA1 "string\s\"xesam:title\"" | tail -1 | grep -Po "(?<=\").*(?=\")")

        if [ ${#artist} -gt 15 ]
        then
            artist=${artist:0:15}"..."
        fi
        np=$(echo "${artist} - ${track}")
        if [ ${#np} -gt 35 ]
        then
            np=${np:0:32}"..."
        fi
    fi
fi
echo "$np"
