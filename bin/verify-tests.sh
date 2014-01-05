#!/bin/bash

RESULTS=$1

find $RESULTS -regex ".*\.log$" | while read f
do
	result=`tail -n 1 $f`
	test=`basename "$f"`

	echo "$test" | grep -q "sat"
	if [ $? -ne 0 ]; then
		echo "$result" | grep -q "^UNSATISFIABLE"
		if [ $? -ne 0 ]
		then
			echo "$test: FAILED (expected UNSATISFIABLE, got: $result)"
		else
			echo "$test: CHECK"
		fi
	else
		echo "$test" | grep -q "unsat"
		if [ $? -ne 0 ]; then
			echo "$result" | grep -q "^SATISFIABLE"
			if [ $? -ne 0 ]; then
				echo "$test: FAILED (expected SATISFIABLE, got: $result)"
			else
				echo "$test: CHECK"
			fi
		else		
			echo "$result" | grep -q "^UNSATISFIABLE"
			if [ $? -ne 0 ]; then
				echo "$test: FAILED (expected UNSATISFIABLE, got: $result)"
			else
				echo "$test: CHECK"
			fi
		fi
	fi
done
