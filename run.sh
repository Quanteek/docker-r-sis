#!/bin/bash

# Set default parallel numbers
if [ -z "$3" ]
then
    parallel=4
else
    parallel=$3
fi
rm p_* y_*
# split input file
split -l2 $1 p_
NPROC=0
for i in $(ls p_*)
do
    echo "running rscript with $i"
    Rscript /home/user01/sis.R $i y_$i #> /dev/null &
    NPROC=$(($NPROC+1))
    if [ "$NPROC" -ge $parallel ]
    then
	wait
	NPROC=0
    fi
done
wait

cat y_* > $2
