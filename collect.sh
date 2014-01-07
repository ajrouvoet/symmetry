#!/bin/bash
OUTDIR=./data/
REF=`git rev-parse HEAD`
TIMEOUT_IN=900
OPTS="-no-inverting-opt -activity-look-freq=1"
#-no-inverting-opt
#-no-inverting-opt -activity-nl-freq=1
#-no-inverting-opt -sym-var-bump
#-no-inverting-opt -sym-usage-var-bump"

echo "$OPTS" | while read opt
do
        echo "-----------------------------------------------------------------------------------------"
        echo ">> running with options: $opt"
        echo "-----------------------------------------------------------------------------------------"
        echo ""

        find minisat/cnf\ test\ files/{fpga,battleship,chnl,Pigeonhole_shuffled,urquhart} -regex ".*\.cnf$" | grep -v "Sym" | while read f
        do
                # handle empty option sets
                if `echo $opt | grep -q "^\s*$"`
                then
                        opttext="vanilla"
                else
                        opttext="$opt"
                fi

                optpath=`echo $opttext | sed "s/\-\| \|:\|;/_/g"`
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
