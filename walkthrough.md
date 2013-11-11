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

Search procedure (as taken from the paper)
------------------------------------------

This is an overview of what happens

1.	Pick a decision variable x (first look at user assumptions, when run out: use pickBranchLit(..))
2.	Assume value for x
3.	Propagate
4.	If no conflict and undecided variables remain: increase the decisionLevel and continue at step one.
	Else: add learned clause and backtrack until one of the variables of the learned clause becomes
	unbound.

The implementation is a bit inverted:

1.	Propagate
2.	If a conflict:
	1.	Backtrack as above

	Else:
	1.	Pick a decision variable x
	2.	Assume value true for x
	3.	Increase decision level
3.	Continue at step 1 if no model found, return l_True otherwise.

Nomen clature
-------------

+	Decision level:
	all variables assigned as a consequence of x is said to be from the same decision level,
	counting from 1 for the first assumption made and so forth. Assignments made before the first
	assumption (decision level 0) are called top-level.

+	Trail:
	Decision made (+bindings resulted from decisions).
	The trail is partitioned in decision levels for backtracking.
