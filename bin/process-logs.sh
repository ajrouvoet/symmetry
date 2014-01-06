#!/bin/bash
INDIR=$1
HERE=`dirname $0`

#find . -regex .*\.log$ -exec vim -Es {} -c % s/Options:s*$/Options: original-SP/g -c wq

find "`pwd`/$INDIR" -regex ".*\.log" | python $HERE/process.py
