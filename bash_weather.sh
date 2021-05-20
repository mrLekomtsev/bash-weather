#!/bin/bash

#Check city
while [ -z "$1" ] 
do
   echo "Please type city name as parametr"
   exit
done

# Check jq package
CHECK=$(apt-cache policy jq | grep Installed)
if [ -z "$CHECK" ]
then
   echo "jq package is not installed"
   apt update && apt install jq
fi

#Download JSON file
curl -s wttr.in/$1?format=j1 > temp.json

#Parse JSON temp file
TEMP=$(jq .current_condition[].temp_C temp.json)
HUMIDITY=$(jq .current_condition[].humidity temp.json)
#Remove temp file
rm temp.json

#Print result
RESULT="Today in $1 : $TEMP°C $HUMIDITY%"
RESULT=${RESULT//\"/}
echo $RESULT
