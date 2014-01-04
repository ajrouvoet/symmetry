#!/bin/bash
INDIR=$1
HERE=`dirname $0`

find "`pwd`/$INDIR" -regex ".*\.log" | python $HERE/process.py
