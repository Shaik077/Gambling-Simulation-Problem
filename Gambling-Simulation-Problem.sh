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
