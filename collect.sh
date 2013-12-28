#!/bin/bash
OUTDIR=./data/
SUITE=$1
BRANCH=`git branch | sed -n '/\* /s///p'`
REF=`git rev-parse HEAD`

find minisat/cnf\ test\ files/$SUITE -regex ".*\.cnf$" | while read f
do
	name=`basename "$f"`
	suite=`basename "$(dirname $f)"`
	outpath="$OUTDIR/$BRANCH/$REF/$suite/$name.log"

	mkdir -p `dirname "$outpath"`

	echo ">> Running $name from suite $suite ($EXC "$f")"
	./minisat/build/release/bin/minisat_core "$f" > $outpath
	echo ">> Done (output in: $outpath)"
done
