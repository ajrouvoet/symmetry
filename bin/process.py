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
r_indeterminate = re.compile( r"INDETERMINATE" )

def get_num_syms( data ):
    match = r_num_syms.search( data )
    assert match, "Woops, data did not contain number of symmetries"

    return int( match.group(1) )

def get_timeout( data ):
    match = r_timeout.search( data )

    return bool( match )

def get_indeterminate( data ):
    match = r_indeterminate.search( data )

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

    if not get_timeout( content ) and not get_indeterminate( content ):
        # solve time
        cpu_time = get_cpu_time( content )

        # number of symmetries
        num_syms = get_num_syms( content )

        # decisions
        decisions = get_decisions( content )
    elif get_indeterminate( content ):
        # solve time
        cpu_time = 'fail'
        num_syms = 'fail'
        decisions = 'fail'
    else:
        cpu_time = "-"
        num_syms = "-"
        decisions = "-"

    return {
        'test': testname,
        'opts': options,
        'syms': num_syms,
        'time': cpu_time,
        'decisions': decisions
    }

def collect( results ):
    opts = []
    agg = {}

    for res in results:
        if res[ 'opts' ] not in opts:
            opts.append( res[ 'opts' ])

        line = agg.get( res.get( 'test' ))

        # if no entry exists, make it
        if line is None:
            line = {
                'symmetries': res[ 'syms' ],
                'results': {}
            }

            agg[ res.get( 'test' )] = line

        # add a result
        line[ 'results' ][ res[ 'opts' ]] = {
            'time': res[ 'time' ],
            'decisions': res[ 'decisions' ],
        }

    content = ""

    # headers
    content += "Test, Input Symmetries"
    for i in [0,1]:
        for o in opts:
            content += ", %s" % o

    content += "\n"

    # data lines
    for test in sorted( agg.keys() ):
        data = agg[ test ]

        st = ""
        st += "%s, %s" % ( test, data[ 'symmetries' ] )

        for o in opts:
            # check if we have results
            st += ", %s" % data[ 'results' ].get( o, {} ).get( 'time', 'no data' )

        for o in opts:
            # check if we have results
            st += ", %s" % data[ 'results' ].get( o, {} ).get( 'decisions', 'no data' )

        content += st + "\n"

    return content

if __name__ == "__main__":
    try:
        results = []
        for path in sys.stdin.readlines():
            results.append( parse_file( path.strip() ))

        print( collect( results ))
    except:
        print( path.strip() )
