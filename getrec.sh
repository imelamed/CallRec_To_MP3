#!/bin/bash

echo "Hit Enter to Display files from today or enter the specific day:"

read PrifferedVar
#-n ${input//[0-9]/}
while [[ -n ${PrifferedVar//[0-9]/} || $PrifferedVar -gt 31 ]]
	do
		printf "\nInvalid choice! Please Press Enter or inster date between 1-31:"
		#read -p "Invalid choice! Please Press Enter or inster date between 1-31:" PrifferedVar
		read PrifferedVar
    done

if [ -z "$PrifferedVar" ]
then
# if PrifferdVar is empty
	DDate=$(date +%F)
	echo "\$DDATE is $DDate"
else
# If PrifferdVar is between 1-31
	DDate=$(date +%Y)"-"$(date +%m)"-"$PrifferedVar
      echo "\$DDate is $DDate"
fi



#echo "PrifferedVar var is: $PrifferedVar"


echo "Listing The Avliable Recored Files for date $DDate"

adb shell <<EOF
ls -la /sdcard/CallRecordings/$DDate
EOF

echo ""
echo "Please Enter the Full Name of the file to pull:"

read PullFile

adb pull /sdcard/CallRecordings/$DDate/$PullFile /home/itamarm/Downloads/Recoreds/

#converting to MP3

MP3File=$(echo $PullFile | awk -F "." '{print $1}')".mp3"
cd /home/itamarm/Downloads/Recoreds/
ffmpeg -i $PullFile -ar 22050 $MP3File
rm $PullFile
nautilus /home/itamarm/Downloads/Recoreds/$MP3File &
