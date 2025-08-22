#!/bin/bash
IFS=$'\n'
count=0
dir=$(pwd)
cache=.play-random-cache-$(echo "$dir" | tr / -)
# Colour constants from https://gist.github.com/vratiu/9780109
TITLE='\033[1;33m'  # Bold yellow
CLI='\033[4;37m'    # Underlined white
NC='\033[0m'        # Reset/No colour
DIR=''
FILE=''
echo
echo -e "\U1F3A7${TITLE}Play Random Audio File${NC}, v1.1, by Michael Z Freeman, 2022, http://michaelzfreeman.org"
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
num_files=${#files[@]} # Count how many elements.
if [ "$num_files" -eq 0 ]; then
    echo "No audio or video files found."
    exit 1
fi
choice="${files[RANDOM % num_files]}"
# Show controls for Alsaplayer
#echo
#echo -e "${CLI}Controls${NC} (case sensitive !)
#v Stop          ${TITLE}l Loop${NC}
#x Play          r Volume Up
#c Pause         w Volume Down
#b Next Song     ${TITLE}h Speed Up${NC}
#z Previous Song ${TITLE}i Speed Down${NC}
#g Seek Forward  q Speed Down Key
#a Seek Backward t Speed Up Key
#${TITLE}f Forward Play${NC}  ${TITLE}s Reverse Play${NC}"
if [ "$1" ];
then
    case $1 in
        # Play in Mixxx deck 1.
        1)
            # Send to CTRL - V paste buffer
            realchoice=`realpath $choice`
            echo \"$realchoice\" | xsel -ib
            echo
            echo -e "\U1F50APlaying ${CLI}\"$choice\"${NC} in Mixxx deck 1 ..."
            echo
            # Using keyboard mapping from https://mixxx.discourse.group/t/this-is-a-mixx-keyboard-for-mixing-without-a-controller-or-mouse/23257/17
            wmctrl -x -a "mixxx.Mixxx"
            sleep 0.5
            #xte "key d"
            xte "keydown Shift_L"
            xte "keydown f"
            xte "keyup Shift_L"
            xte "keyup f"
            xte "keydown Control_L"
            xte "keydown o"
            xte "keyup Control_L"
            xte "keyup o"
            sleep 2
            xte "keydown Control_L"
            xte "keydown v"
            xte "keyup Control_L"
            xte "keyup v"
            sleep 1
            xte "key Return"
            sleep 1
            xte "key d"
            # Use mpv to show cover art only (start paused)
            #mpv --audio-pitch-correction=no --cover-art-auto=no --pause --no-terminal --volume=$1 "$choice"
            ;;
        # Play in Mixxx deck 2.
        2)
            realchoice=`realpath $choice`
            echo \"$realchoice\" | xsel -ib
            echo
            echo -e "\U1F50APlaying ${CLI}\"$choice\"${NC} in Mixxx deck 2 ..."
            echo
            # Load into Mixxx - https://funprojects.blog/tag/xdotools/
            wmctrl -x -a "mixxx.Mixxx"
            sleep 0.5
            # Use ALT - Left/Right Arrow to forcibly eject playing track
            #xte "keydown Alt_L"
            #xte "keydown Left"
            #xte "keyup Alt_L"
            #xte "keyup Left"
            #xte "key l"
            xte "keydown Shift_L"
            xte "keydown :"
            xte "keyup Shift_L"
            xte "keyup :"
            xte "keydown Control_L"
            xte "keydown Shift_L"
            xte "keydown o"
            xte "keyup Control_L"
            xte "keyup Shift_L"
            xte "keyup o"
            sleep 2 # Or use wmctrl to check for file selection window
            xte "keydown Control_L"
            xte "keydown v"
            xte "keyup Control_L"
            xte "keyup v"
            sleep 1
            xte "key Return"
            sleep 1
            xte "key l"
            # Use mpv to show cover art only (start paused)
            #mpv --audio-pitch-correction=no --cover-art-auto=no --pause --no-terminal --volume=$1 "$choice"
            ;;
        mpv)
            # Send to CTRL - V paste buffer
            echo mpv --audio-pitch-correction=no --cover-art-auto=no --volume=$2 \"$choice\" | xsel -ib
            echo
            echo -e "\U1F50APlaying using ${CLI}mpv \"$choice\"${NC}..."
            echo
            # --audio-display=no
            mpv --audio-pitch-correction=no --cover-art-auto=no --volume=$2 "$choice"
    esac
else
    echo
    echo -e Options: 1 or 2 to play in Mixxx deck, mpv with volume 0 to 100 to play with mpv.

fi
