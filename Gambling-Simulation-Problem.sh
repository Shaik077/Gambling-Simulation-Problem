STAKEPERDAY=100
BETPERGAME=1
echo "User_Percentage"
read User_Percentage
echo "Number_Of_Days" 
read Number_Of_Days
declare -A Month
SimulateOneGame(){
	WIN=1
	LOSE=0

	Check=$((RANDOM%2))
	if [ $Check -eq $WIN ];
	then
		ResultAmount=$BETPERGAME
	else
		ResultAmount=-$BETPERGAME
	fi
}
CurrentAmount=$STAKEPERDAY
SimulateOneDayTillResignHelper(){
                  Percentage=$(($User_Percentage * $STAKEPERDAY/100))
                  UpperLimit=$(($Percentage+$STAKEPERDAY))
                  lowerLimit=$(($STAKEPERDAY-$Percentage))
	while [ $CurrentAmount -gt $lowerLimit -a $CurrentAmount -lt $UpperLimit ]
	do
		SimulateOneGame
		CurrentAmount=$(($CurrentAmount+$ResultAmount))
	done
}
SimulateOneDayTillResign(){
	SimulateOneDayTillResignHelper
	echo "Resign for the day"
	echo $CurrentAmount
}
SimulateOneDayTillResign
TotalWin=0
TotalLose=0
SimulateGameForTwentyDaysHelper(){
	for (( Day=1; Day<$Number_Of_Days; Day++ ))
	do
		CurrentAmount=$STAKEPERDAY
		SimulateOneDayTillResignHelper
		if [ $CurrentAmount -gt $STAKEPERDAY ]
		then
			WinAmountPerDay=$(($CurrentAmount - $STAKEPERDAY))
			TotalWin=$(($TotalWin + $WinAmountPerDay))
                        Month["$Day"]=$TotalWin
		else
			LoseAmountPerDay=$(($STAKEPERDAY-$CurrentAmount))
			TotalLose=$(($TotalLose + $LoseAmountPerDay))
                        Month["$Day"]=$TotalLose
		fi
                  
	done
 echo ${Month[@]}
}
SimulateGameForTwentyDays(){
	SimulateGameForTwentyDaysHelper
	echo "TotalWin" = $TotalWin
	echo "TotalLose"= $TotalLose
	if [ $TotalWin -gt $TotalLose ]
	then
		WinBy=$(($TotalWin-$TotalLose))
		echo "Total Amount won : $WinBy"
	else
		LostBy=$(($TotalLose-$TotalWin))
		echo "Total Amount lost : $LostBy"
	fi

}
SimulateGameForTwentyDays
luckiestDay=$( printf "%s\n" ${Month[@]} | sort -nr | head -1 )
unluckiestDay=$( printf "%s\n" ${Month[@]} | sort -nr | tail -1 )

for data in "${!Month[@]}"
   do
      if [[ ${Month[$data]} -eq $luckiestDay ]]
      then
         echo "Luckiest Day- $data $luckiestDay"
       fi

      if [[ ${Month[$data]} -eq $unluckiestDay ]]
      then
         echo "Unluckiest Day- $data $unluckiestDay"
      fi
   done



if [[ $TotalWin -gt $TotalLose ]]
then
       echo "ContinuePlaying..."
else
     echo "StopPlaying..."
fi
