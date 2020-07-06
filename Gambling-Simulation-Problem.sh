#! /bin/bash -x

STAKE_PER_DAY=100
BET_PER_GAME=1
simulateOneGame(){
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
simulateOneGame
echo $ResultAmount
