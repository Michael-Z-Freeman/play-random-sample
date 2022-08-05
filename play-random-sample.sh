#!/bin/bash
IFS=$'\n'
count=0
dir=$(pwd)
cache=.play-random-cache-$(echo "$dir" | tr / -)
BLUE='\033[0;34m'
NC='\033[0m'
echo -e "\U1F3A7${BLUE}Play Random Audio File${NC}, v1.1, by Michael Z Freeman, 2022, http://michaelzfreeman.org"
if test -f "$cache"; then
	echo
    echo -e "\U1F477Retrieving audio and video files from cache file..."
    readarray -t files < "$cache"
else
echo
echo -e "\U1F50EScanning for audio and video files in current directory (result will be cached) ..."
listall=`tree -fi` # Read in all files in current and sub-folders with full path.
files=($listall) # Read into array variable.
for i in "${files[@]}"
do
	echo Current file @ index $count: "$i"
	check=`mimetype -b "$i" | grep -e audio/ -e video/`
	echo Mime type: $check
	if [ -z "$check" ];
	then
		unset files[$count] # Remove non audio or video file from array
	fi
	count=`expr $count + 1`;
done
echo
echo -e "\U1F477Writing cache..."
for i in "${files[@]}"
do
	touch "$cache"
	echo "$i" >> "$cache"
done
fi
echo
echo -e "\U1F477Generating random choice from scanned audio and video files..."
num_files=${#files[*]} # Count how many elements.
num_files=`expr $num_files - 1`;
choice="${files[$((RANDOM%num_files))]}"
echo
echo -e "\U1F50APlaying '$choice'..."
echo
mpv --audio-display=no --cover-art-auto=no "$choice"
