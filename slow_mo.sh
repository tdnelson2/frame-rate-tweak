#!/bin/bash

file_extension=""
source_frame_rate=""
target_frame_rate=""
output_folder=""

# Process parameters
if [ $# != 0 ] ; then
	printf "there are $# arguments\n"
	flag=""
	for option in $@ ; do
		printf "current option: $option\n"
		printf "current flag: $flag\n"
		case "$flag" in
			-e) file_extension="$option"
				printf "file_extension: $file_extension\n"
				;;
			-s) source_frame_rate="$option"
				printf "source_frame_rate: $source_frame_rate\n"
				;;
			-t) target_frame_rate="$option"
				printf "target_frame_rate: $target_frame_rate\n"
				;;
			-o) output_folder="$option"
				printf "output_folder: $output_folder\n"
				;;
		esac
		flag="$option"
	done
fi

printf "$file_extension\n"
printf "$source_frame_rate\n"
printf "$target_frame_rate\n"
printf "$output_folder\n"

# Give feedback if parameters are missing
if [ file_extension == "" -o "$source_frame_rate" == "" -o "$target_frame_rate" == "" -o "$output_folder" == "" ] ; then
      printf "`basename ${0}`: usage: [-e File Extension to Target (ex: MOV)] | [-s Frame Rate to Target (ex: 59.94)] | [-t Desired Output Frame Rate (ex: 29.97)] | [-o Output Folder (ex: slow-motion)]" 
      exit 1 # Command to come out of the program with status 1
fi

# Do conversion
mkdir "$output_folder"
for fil in *."$file_extension" ; do
    frame_rate=$(ffmpeg -i "$fil" 2>&1 | sed -n "s/.*, \(.*\) fp.*/\1/p")
    if [[ "$frame_rate" == "$source_frame_rate" ]]
        then
        printf "\n\n\n\n\n$fil frame rate is $source_frame_rate\nconverting to $target_frame_rate...\n\n\n\n\n"
        ffmpeg -i "$fil" -c copy -an -video_track_timescale $target_frame_rate "$output_folder/$fil"
    fi
done

# Cleanup
# contents=$(ls "$output_folder")
# if [[ "$contents" == "" ]] ; then
# 	rm -R "$output_folder"
# 	printf "\nNo MOV files  (-s)\n"
# else
# 	printf "\nFrame rate change succesfull for the following videos:\n\n$contents\n\n"
# fi

exit 1
