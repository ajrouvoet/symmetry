#!/bin/bash
OUTDIR=./data/
SUITE=$1
REF=`git rev-parse HEAD`
OPTS="-rnd-freq=0.02 -activity-nl-freq=1
-rnd-freq=0.02 -sym-count-freq=1"

echo "$OPTS" | while read opt
do
	echo "-----------------------------------------------------------------------------------------"
	echo ">> running with options: $opt"
	echo "-----------------------------------------------------------------------------------------"
	echo ""

	find minisat/cnf\ test\ files/$SUITE -regex ".*\.cnf$" | while read f
	do
		optpath=`echo $opt | sed "s/\-\| \|:\|;/_/g"`
		name=`basename "$f"`
		suite=`basename "$(dirname $f)"`
		outpath="$OUTDIR/$REF/$optpath/$suite/$name.log"
		outdir=`dirname "$outpath"`

		mkdir -p "$outdir"

		echo ">> Running $name from suite $suite ($EXC "$f")"
		./minisat/build/release/bin/minisat_core "${f}" > "${outpath}"
		echo ">> Done (output in: $outpath)"
		echo ""
	done
done
