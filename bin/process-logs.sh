#!/bin/bash
INDIR=$1

find "$INDIR" -regex ".*\.log$" | while read f
do
	python process.py $f
done
