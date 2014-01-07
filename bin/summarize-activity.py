#!/bin/python
import sys
import csv
import numpy

if __name__ == "__main__":
    assert len(sys.argv) >= 1, "No file name given"

    with open(sys.argv[1], 'r') as fh:
        rows = csv.reader(fh)
        activity = [ int(row[0]) for row in rows ]
        print(numpy.mean(activity), numpy.std(activity))
