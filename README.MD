# ffmpeg Frame Rate Tweaker
Batch convert frame rate of all videos withing a folder without transcoding
## Use
* Be sure you have [ffmepg](https://trac.ffmpeg.org/wiki/CompilationGuide/MacOSX) installed. If you don't, this program will not work.
* In terminal, go to directory containing videos (ex: `cd path/to/video/folder`).
* Run the script:
~~~
sh /path/to/the/script/frame_rate_tweak.sh -e mov -s 59.94 -t 29.97 -o slow-motion-output
~~~
* All parameters are required:
~~~
-e          File Extension of Files to Target (ex: MOV or mov)
-s          Frame Rate to Target (ex: 59.94)
-t          Desired Output Frame Rate (ex: 29.97)
-o          Output Folder (ex: slow-motion)
~~~
## Known issues
* Audio is no longer works after conversion. There is probably a way to fix this, but since I didn't need the audio, I didn't spend time to figure it out.
* Playback may not be guarinteed to work correctly on all players
* Timecode may be corrupted for some files