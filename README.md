# Integrated CLI DJ'ing Environment

![play-radnom-sample screen shot](https://github.com/Michael-Z-Freeman/play-random-sample/raw/main/play_random_sample_screenshot.png "screen shot") 

Scan folder and sub-folders for all audio &amp; video, cache results, then play random selection.

Previously [I published a script](https://michaelzfreeman.org/linux-cli-bash-play-random-audio-file-music-track-or-display-random-image/) that selected a random audio file (or any file). However it assumed that the folder where you have your files is exclusively filled with audio file types. As a DJ I save mixes to a folder along with text and HTML files that hold the track list. It was getting a little laborious having to re-trigger the script over and over until I hit an actual audio file. So I wrote a script that actually checks the file MIME type. The script also has added colour and emoji’s for humanity factor 100% 🤱!

# The Next Level

While tinkering with this script I noticed it was becoming VASTLY easier for me to select tracks, experiment and DJ at the command line. However mpv has a very unsophisticated pitch control and other functions. Then I discovered [Alsaplayer](http://alsaplayer.sourceforge.net/) and paradise was regained ! That has a fully functional pitch control as well as reverse and loop points. This in a way starts replicating the SIMPLICITY of the tried and tested two vinyl record decks and a mixer with two faders and a cross fader. That's all that is needed and has been the basis of all DJ selecting and/or creative DJ'ing over the last 60 years. The tech has become horribly complex both software and hardware with manufacturers all vying for your attention with a veritable typhoon of features and technocratic solutions. 

But lo, your saviour is at hand ! The Integrated CLI DJ'ing Environment will free you from your bondage, your slavery. The Matrix of stifling and boring music and DJ'ing "solutions" will be rent asunder and the JOY and LOVE inherent in the music will come pouring out. A'men.

# Alsaplayer

![Alsaplayer ultra cool](https://user-images.githubusercontent.com/951566/187039840-b995d67f-5ec6-4121-bcc5-00562458383c.jpg)

Alsaplayer needs building [from source](https://github.com/alsaplayer/alsaplayer). Pre-built packages for Ubuntu seem to be very unstable although I have not extensivly tested why this is. Anyway, building from source will give Alsaplayer any updates in the libraries it is based on. Alsaplayer could not play Opus files but I fixed this by adding the following after line 292 in "/alsaplayer/input/sndfile/sndfile_engine.c" ...

```
|| !strcasecmp(dot, "opus")
```
