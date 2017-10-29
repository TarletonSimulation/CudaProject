#!/bin/bash

. scripts/tsx.env

cd $CudaProject

line_count=0
headers=$(find $CudaProject/include -type f | grep -i .h$)
sources=$(find $CudaProject/src -type f | grep -i .cu$)

for x in $headers $sources
do
	k=$(cat $x | wc -l)
	line_count=$(expr $line_count + $k)
done

printf "Total Lines in \'$(basename $CudaProject)\':\t$line_count\n"

