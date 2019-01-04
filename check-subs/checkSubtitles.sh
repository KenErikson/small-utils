#!/bin/bash

#give the path to Plex folder containing Movies and/or TV Shows-dir
# Example ./checkSubtitles.sh -vv /mnt/Plex/Movies/ to add a ignore.sub

paths=( "/mnt/Plex/" "/mnt2/Plex/" "/mnt3/torrent/" )
tvdir="TV Shows"
movdir="Movies"
subdirs=( "$tvdir" "$movdir" )
#fileext=( "mp4" "avi" "mkv")

RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

IFS=$'\012'

if [[ "$2" != "" ]]; then
  touch "${2}ignore.sub"
fi
COUNT=0
echo
echo -e "${GREEN}#######################"
echo -e "Checking subtitles in:"
echo -e "  ${YELLOW}${paths[@]}${GREEN}"
echo -e "#######################${NC}"
echo
for subpath in "${subdirs[@]}"; do
for path in "${paths[@]}"; do
  #echo "$path"
    #echo $subpath
    if [[ -d $path"$subpath" ]]; then
      #cd $path"$subpath"
      #echo $path"$subpath"
      #for ext in ${fileext[@]};do
      #echo $ext
      #a=($(find . -type f ))
      #a=$(find "$path$subpath" -name '*.mp4' -or -name '*.avi' -or -name '*.mkv' )
      #echo ${a[@]}
      for f in $(find "$path$subpath" -name '*.mp4' -or -name '*.avi' -or -name '*.mkv' -or -name "*.flv" ); do
        #echo $f 
        #echo "checking ${f%/*}/ignore.sub"
        #echo -e "${YELLOW}${f}${NC}"
if [[ ! "${f}" == *"sample."* ]] && [[ ! "${f}" == *"Sample."* ]] && [[ ! "${f}" == *"Extras."* ]]; then
        if [[ -f "${f%.*}.srt" ]] || [[ -f "${f%.*}.en.srt" ]]; then
          if [[ "$1" == "-v" ]] || [[ "$1" == "-vv" ]];then
          echo -e "${GREEN}Subs found: ${NC}$f"
          fi
          #echo "found ${f#/*}"
        else
        if [[ ! -f "${f%/*}/ignore.sub" ]] && [[ ! -f "${f%.*}.ignore.sub" ]]; then
          echo -e "${RED}No subtitl: ${NC}$f"
         ((COUNT++))
         else
          if [[ "$1" == "-vv" ]]; then
            echo -e "${YELLOW}Ignored:    ${NC}$f"
          fi
        fi
        fi
       fi
      done
      #done
    fi
  done
done
echo
echo -e "${RED}Missing Subtitles: ${NC}$COUNT"
