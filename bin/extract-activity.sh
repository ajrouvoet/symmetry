#!/bin/bash
INDIR=$1
HERE=`dirname $0`

find "`pwd`/$INDIR" -regex ".*\.log" | while read f
do
	cat $f | grep "ActiveSyms:" | sed -E "s/^ActiveSyms. ([0-9]+).*/\1/g"
done
