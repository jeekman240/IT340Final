#!/bin/bash
errorcount=0
useroffset=$2
offset=$useroffset
currentdate=$(date +"%b %d")
prevdate=$(date --date="-$offset days" +'%b %d')

#echo "my script runs" #checking if script executes
if [ -f "$1" ]
then

	#making sure the date variables are being defined correctly
	#echo "current date is $currentdate"
	#echo "previous date is $prevdate"
	while [ $offset -gt 0 ]
	do
		prevdate=$(date --date="-$offset days" +'%b %d')
		cat $1 | grep -e "ERROR" -e "error" -e "err" -e "EE" | grep "$prevdate" >> /home/jeekman24/myerror."$currentdate"
		((offset--))
		errorcount=$(($errorcount+$(cat $1 | grep -e "ERROR" -e "error" -e "err" -e "EE" | grep "$prevdate" | wc -l)))
	done
	
	#output number of errors
	echo $'\n'"$errorcount errors found in the last $useroffset day(s)" $'\n' >> /home/jeekman24/myerror."$currentdate"
fi
