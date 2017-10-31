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

# to account for the files that were included from 'Cuda by Example' #
fx=$(find $CudaProject/include/cuda -type f)
dx=0

for x in $fx
do
	df=$(cat $x | wc -l)
	dx=$(expr $dx + $df)
done

line_count=$(expr $line_count - $dx)

printf "Total Lines in \'$(basename $CudaProject)\':\t$line_count\n"

