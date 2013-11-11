Solving instances
=================

The big picture
---------------

1.	The main method in Main.cc constructs a Solver instance
2.	One of the solve() methods is called (Solver.h), calling solve\_() in turn (Solver.cc)
3.	The current model/conflicts are cleared (solve can be called multiple times, in between
	clauses/vars/constraints can be added)
4.	search() is called on the solver.
	It gets a max no of conflicts as argument, restarting if it outgrows it's budget.
	Restarts get less frequent by increasing the number of conflicts allowed every iteration.
5.	If search return true, the values of the variables currently in the solver are copied to the
	model and the solver returns.
