#! /bin/bash -x

STAKE_PER_DAY=100
BET_PER_GAME=1
echo "User_Percentage"
read User_Percentage
echo "Number_Of_Days" 
read Number_Of_Days

SimulateOneGame(){
	WIN=1
	LOSE=0

	Check=$((RANDOM%2))
	if [ $Check -eq $WIN ];
	then
		ResultAmount=$BET_PER_GAME
	else
		ResultAmount=-$BET_PER_GAME
	fi
}

CurrentAmount=$STAKE_PER_DAY
SimulateOneDayTillResignHelper(){
                  Percentage=$(($User_Percentage * $STAKE_PER_DAY/100))
                  UpperLimit=$(($Percentage+$STAKE_PER_DAY))
                  lowerLimit=$(($STAKE_PER_DAY-$Percentage))

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
		CurrentAmount=$STAKE_PER_DAY
		SimulateOneDayTillResignHelper
		if [ $CurrentAmount -gt $STAKE_PER_DAY ]
		then
			WinAmountPerDay=$(($CurrentAmount - $STAKE_PER_DAY))
			TotalWin=$(($TotalWin + $WinAmountPerDay))
		else
			LoseAmountPerDay=$(($STAKE_PER_DAY-$CurrentAmount))
			TotalLose=$(($TotalLose + $LoseAmountPerDay))
		fi
	done
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

PerDayOutcome(){
	Month=()
        totalAmount=0
	for (( Day=1; Day<=$Number_Of_Days; Day++ ))
	do
		CurrentAmount=$STAKE_PER_DAY
                 SimulateOneDayTillResignHelper
		Month[((totalAmount++))]=$CurrentAmount
	done
	for (( Day=1; Day<$Number_Of_Days; Day++ ))
	do
		echo "Day $(($Day+1)) : ${Month[$Day]}"
	done

}
PerDayOutcome

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
