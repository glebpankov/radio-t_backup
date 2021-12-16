#!/bin/bash

WORK_DIR='/home/devops/downloads/radio-t'
ADDSNAME='_80k.mp3'
filename80=''

cd $WORK_DIR

number_of_podcast=$(ls *.num | cut -c1-3)

current_date=$(date +%Y-%m-%d)

mkdir ${WORK_DIR}'/'{$current_date}

cd ${WORK_DIR}'/'{$current_date}

for (( i=1; i <= 360; i++ ))
do

	mplayer https://stream.radio-t.com -dumpstream -dumpfile ${current_date}_podcast_${number_of_podcast}_$i.mp3 -vc dummy -vo null

	sleep 10s

done

sleep 1m

ls | grep .mp3 > mylist.txt

#ffmpeg -i ${current_date}_podcast_${number_of_podcast}.mp3 -codec:a libmp3lame -b:a 80k ${current_date}_podcast_${number_of_podcast}_80k.mp3

while read $filename
do
	$filename80=${filename%.*}
	$filename80+=$ADDSNAME
	ffmpeg -i $filename -codec:a libmp3lame -b:a 80k $filename80
	$filename80=''
done < ./mylist.txt


let "number_of_podcast = number_of_podcast + 1"

rm /home/devops/downloads/radio-t/*.num

touch /home/devops/downloads/radio-t/${number_of_podcast}.num
