#!/bin/bash

file_extension=""
source_frame_rate=""
target_frame_rate=""
output_folder=""

# Process parameters
if [ $# != 0 ] ; then
	flag=""
	for option in $@ ; do
		case "$flag" in
			-e) file_extension="$option"
				;;
			-s) source_frame_rate="$option"
				;;
			-t) target_frame_rate="$option"
				;;
			-o) output_folder="$option"
				;;
		esac
		flag="$option"
	done
fi

# Give feedback if parameters are missing
if [ file_extension == "" -o "$source_frame_rate" == "" -o "$target_frame_rate" == "" -o "$output_folder" == "" ] ; then
      printf "`basename ${0}`: usage: [-e File Extension to Target (ex: MOV or mov)] | [-s Frame Rate to Target (ex: 59.94)] | [-t Desired Output Frame Rate (ex: 29.97)] | [-o Output Folder (ex: slow-motion)]" 
      exit 1 # Command to come out of the program with status 1
fi

# Do conversion
mkdir "$output_folder"
for fil in *."$file_extension" ; do
    frame_rate=$(ffmpeg -i "$fil" 2>&1 | sed -n "s/.*, \(.*\) fp.*/\1/p")
    if [[ "$frame_rate" == "$source_frame_rate" ]] ; then
        printf "\n\n\n\n\n$fil frame rate is $source_frame_rate\nconverting to $target_frame_rate...\n\n\n\n\n"
        ffmpeg -i "$fil" -c copy -an -video_track_timescale $target_frame_rate "$output_folder/$fil"
    fi
done

# Cleanup
contents=$(ls "$output_folder")
if [[ "$contents" == "" ]] ; then
	rm -R "$output_folder"
	printf "\nNo $file_extension files found\n"
else
	printf "\nFrame rate change succesfull for the following videos:\n\n$contents\n\n"
fi

exit 1
