#!/bin/bash
PREFIX=$1
SUBNET=$2
HOST=$3
INTERFACE=$4

trap 'echo "Ping exit (Ctrl-C)"; exit 1' 2

# Checks #
#-----------------------------------------

## PREFIX ##
if [[ -z "$PREFIX" ]]; then
	echo "\$PREFIX must be passed as first positional argument"
	exit 1
fi

## SUBNET ##
### Check SUBNET exists ###
if [[ -z "$SUBNET" ]]; then
	echo "\$SUBNET must be passed as first positional argument"
	exit 1
fi

### Check SUBNET range ###
if [[ "$SUBNET" -le "0" ]]; then
echo "\$SUBNET must be in range from 0 to 255"
exit 1
fi

if [[ "$SUBNET" -ge "255" ]]; then
echo "\$SUBNET must be in range from 0 to 255"
exit 1
fi



## HOST ##
### Check HOST exists ###
if [[ -z "$HOST" ]]; then
	echo "\$SUBNET must be passed as first positional argument"
	exit 1
fi

### Check HOST range ###
if [[ "$HOST" -le "1" ]]; then
echo "\$SUBNET must be in range from 1 to 254"
exit 1
fi

if [[ "$HOST" -ge "255" ]]; then
echo "\$SUBNET must be in range from 1 to 254"
exit 1
fi

#-----------------------------------------


for ((i=0; i <= $SUBNET; i++))
do
	for ((j=1; j <= $HOST; j++))
	do
		echo "[*] IP : "$PREFIX"."$i"."$j
		arping -c 1 -i $INTERFACE $PREFIX"."$i"."$j 2> /dev/null
	done
done
