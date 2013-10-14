#!/bin/bash

echo "* Make release version without the simplification extension *"
make cr

echo "* Run UNSATISFIABLE example *"
./build/release/bin/minisat_core ./cnf\ test\ files/battleship/battleship-05-08-unsat.cnf

echo "* Run SATISFIABLE example *"
./build/release/bin/minisat_core ./cnf\ test\ files/battleship/battleship-14-27-sat.cnf
