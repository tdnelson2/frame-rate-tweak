# FFmpeg Frame Rate Tweaker
Batch convert frame rate of all videos within a folder without transcoding

## FFmpeg
* Be sure you have [FFmepg](https://trac.ffmpeg.org/wiki/CompilationGuide) installed. If you don't, this script will not work.

## Motivation
* On a recent trip to Rwanda I gathered over 1,000 video clips for a project I'm working on for a nonprofit. Some of the video was shot in 59.94 fps while others were shot in 29.97 fps. By default, 59.94 fps videos playback at normal speed. Viewing them in slow motion is a tedious process of parsing through which ones are 59.94 fps, bringing them into Final Cut, setting their playback to 50% speed, then exporting (re-encoding). This script does all that without the need to re-encode. It simply copies each video to a new folder and changes the metadata for each frame in the video to match the desired frame rate.

## Use
* In terminal, go to directory containing videos (ex: `cd path/to/video/folder`).
* Run the script:
~~~
sh /path/to/the/script/frame_rate_tweak.sh -e mov -s 59.94 -t 29.97 -o slow-motion-output
~~~
* All parameters are required:
~~~
-e          File Extension of Files to Target (ex: MOV)
-s          Frame Rate to Target (ex: 59.94)
-t          Desired Output Frame Rate (ex: 29.97)
-o          Output Folder (ex: slow-motion) (this folder is created if it doesn't already exist)
~~~

## Known issues
* Audio no longer works after conversion. There is probably a way to fix this, but since I generally don't need audio for slow motion video, I didn't spend time figuring it out.
* Playback is not guarinteed to work correctly on all players.
* According to the warning message FFmpeg provides when running the script, timestamps may be incorrect after the conversion. I'm not entirely sure what this means in practice. DSLR video doesn't have a running timecode so this wasn't a problem for me. Perhaps it causes issues for video shot on traditional video cameras.
* Doesn't work for speeding up videos. Only slowing down.
