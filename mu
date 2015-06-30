#!/bin/bash

music_path="${HOME}/Music/iTunes/iTunes Media/Music"
playlist_path="${HOME}/.config/mpv/mu-playlist.txt"

mpv_options=' --no-border --msg-level=vd=error,ffmpeg/video=fatal,ffmpeg/demuxer=fatal'
is_gui='no'
is_osc=' --no-osc'
dimensions='300x300-16+16'

while getopts ":gostkd:m:" opt; do
  case $opt in
  	g) 	is_gui='attachment';;
	o)	is_osc=' --osc';;
    s) 	mpv_options+=" --shuffle";;
	t)	mpv_options+=" --ontop";;
	k)	mpv_options+=" --input-media-keys=no";;
	d)	dimensions="$OPTARG";;
	m) 	mpv_options+=" $OPTARG";;
    \?) echo "Invalid option -$OPTARG" >&2; exit 1;;
  esac
done
shift $((OPTIND - 1))

IFS=""
files=($music_path/${1:-}*/${2:-}*/*${3:-}*)
unset IFS

printf "%s\n" "${files[@]}" > $playlist_path

mpv ${mpv_options:-} --playlist=$playlist_path --audio-display=$is_gui $is_osc --geometry=$dimensions
