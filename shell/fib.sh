#!/bin/bash

fib () {
    local n=$1
    if [ $n -eq 1 ]; then
	return 1
    else
	fib $((n - 1))
	local m=$?
	return $((n * m))
    fi
}

fib 5
echo $?

fib2 () {
    local init=1
    for i in `seq 2 $1`; do
	init=$((init*i))
    done
    echo ${init}
}

fib2 10

fib3 () {
    local n=$1
    echo $n
    if [ $n -eq 1 ];then
	echo 1
    else
	local m=$(fib3 $((n - 1)))
	echo $m
	echo $(expr m \* n)
    fi
}

fib3 10
