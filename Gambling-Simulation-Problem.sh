#! /bin/bash -x

STAKE_PER_DAY=100
BET_PER_GAME=1
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
echo $ResultAmount
CurrentAmount=$STAKE_PER_DAY
SimulateOneDayTillResignHelper(){
	read User_Percentage
                  Percentage=$(($User_Percentage * $STAKE_PER_DAY/100))
                    UpperLimit=$(($Percentage+$STAKE_PER_DAY))
                         lowerLimit=$(($Percentage-$STAKE_PER_DAY))
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
	for (( i=0; i<20; i++ ))
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
	echo $TotalWin
	echo $TotalLose
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
