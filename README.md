# play-random-sample
Scan folder and sub-folders for all audio &amp; video, cache results, then play random selection.

Previously [I published a script](https://michaelzfreeman.org/linux-cli-bash-play-random-audio-file-music-track-or-display-random-image/) that selected a random audio file (or any file). However it assumed that the folder where you have your files is exclusively filled with audio file types. As a DJ I save mixes to a folder along with text and HTML files that hold the track list. It was getting a little laborious having to re-trigger the script over and over until I hit an actual audio file. So I wrote a script that actually checks the file MIME type. The script also has added colour and emoji’s for humanity factor 100% 🤱!
