#!/bin/sh

function seq {
    left=$1
    right=$2
    while [ $left -le $right ]; do
	echo $left
	left=`expr $left + 1`
    done   
}

for i in `seq $1 $2`; do
    echo $i
done
