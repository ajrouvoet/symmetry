#!/bin/bash
INDIR=$1
HERE=`dirname $0`

find "$INDIR" -regex ".*\.log" | while read f
do
	python $HERE/process.py $f
done
