#!/bin/bash
OUTDIR=./data/
SUITE={battleship chnl fpga Pigeonhole Pigeonhole_shuffled urquhart xorchain}
REF=`git rev-parse HEAD`
TIMEOUT_IN=900
OPTS=" "
#-rnd-freq=0.02
#-rnd-freq=0.02 -sym-var-bump
#-rnd-freq=0.02 -sym-usage-var-bump
#-rnd-freq=0.02 -activity-nl-freq=1
# -rnd-freq=0.02 -sym-count-freq=1" # for sym-count heuristic

echo "$OPTS" | while read opt
do
	echo "-----------------------------------------------------------------------------------------"
	echo ">> running with options: $opt"
	echo "-----------------------------------------------------------------------------------------"
	echo ""

	find minisat/cnf\ test\ files/"$SUITE" -regex ".*\.cnf$" | grep -v "Sym" | while read f
	do
		optpath=`echo $opt | sed "s/\-\| \|:\|;/_/g"`
		name=`basename "$f"`
		suite=`basename "$(dirname $f)"`
		outpath="$OUTDIR/$REF/$optpath/$suite/$name.log"
		outdir=`dirname "$outpath"`

		mkdir -p "$outdir"

		echo ">> Running $name from suite $suite ("$f")"
		echo ">> CMD: ./minisat/build/release/bin/minisat_core $opt ${f}"

		# collect output
		echo "Test: $name" > "${outpath}"
		echo "Options: $opt" >> "${outpath}"
		echo "$opt"
		data="`timeout ${TIMEOUT_IN} ./minisat/build/release/bin/minisat_core $opt "$f"`"

		if [ $? != 124 ]
		then
			echo "$data" >> "${outpath}"
		else
			echo "TIMEOUT" >> "${outpath}"
		fi

		echo ">> Done (output in: $outpath)"
		echo ""
	done
done
