#!/usr/bin/python
import re
import sys
import os

# get the data we are interested in
r_test_name = re.compile( r"Test: (.*)\.cnf" )
r_num_syms = re.compile( r"\|\s+Number of symmetries:\s*(\d+)\s*\|" )
r_cpu_time = re.compile( r"\s*CPU time\s*:\s*(\d+.\d*)\s*s" )
r_decisions = re.compile( r"\s*decisions\s*:\s*(\d+)" )
r_options = re.compile( r"Options:\s*(.*)\s*" )
r_timeout = re.compile( r"TIMEOUT" )

def get_num_syms( data ):
    match = r_num_syms.search( data )
    assert match, "Woops, data did not contain number of symmetries"

    return int( match.group(1) )

def get_timeout( data ):
    match = r_timeout.search( data )

    return bool( match )

def get_cpu_time( data ):
    match = r_cpu_time.search( data )

    assert match, "Woops, data did not contain CPU TIME"
    return float( match.group(1) )

def get_decisions( data ):
    match = r_decisions.search( data )
    assert match, "Woops, data did not contain number of decisions"

    return int( match.group(1) )

def get_test_name( data ):
    match = r_test_name.search( data )
    assert match, "Woops, could not match test name"

    return match.group(1)

def get_options( data ):
    match = r_options.search( data )
    assert match, "Woops, could not match options"

    return match.group(1)

def parse_file( fpath ):
    with open( fpath ) as fh:
        content = fh.read()

    # get the options
    testname = get_test_name( content )

    # get the testname
    options = get_options( content )

    if not get_timeout( content ):
        # solve time
        cpu_time = get_cpu_time( content )

        # number of symmetries
        num_syms = get_num_syms( content )

        # decisions
        decisions = get_decisions( content )
    else:
        cpu_time = "timeout"
        num_syms = "-"
        decisions = "-"

    print( "%s, %s, %s, %s, %s" % (
        testname,
        options,
        num_syms,
        cpu_time,
        decisions
    ))

if __name__ == "__main__":
    assert len( sys.argv ) > 0, "Too few arguments given"
    parse_file( sys.argv[1] )
