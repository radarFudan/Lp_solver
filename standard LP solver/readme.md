## input

在runfile.m中

将A, b, c三个数据放在testfile.m里以赋值的形式存放。
也可以用老师给出的load进行读入数据.

## run

run the runfile script in matlab console.

## output

[mat, feasible, opt_value, opt_x, x_0,steps1, steps2] = simplex_lp(A, b, c);

#### mat: the final tableau of the problem;

#### feasible: 
    If feasible = 0,  then the problem is solvable with a finite optimal value.
    If feasible = 1,  then the problem is infeasible, which means its optimal value is -inf.
    If feasible = -1, then the problem is unbounded below, which means its optimal value is -inf.

#### opt_x: The correspondent optimal x for optimal value.

#### opt_value: The optimal value = c' * opt_x.

#### x_0: the basic feasible solution we get from phase I

#### steps_1: number of steps taken in phase I(including drive the aritifical variables out of the table)

#### steps_2: number of steps taken in phase II

#### Features introduced in this program:

a) two-phase simplex method
b) drive artifical variable out of the basis so that I can continue use the data from mat to compute the phase II.
c) able to eliminates redundant constraints. 

##### Remark:

The number -233 is simply a place holder. 

(
Probelm description:
A can be degenerate
A: 50 * 500
)

Shida Wang
2019.04.14

#### benchmark:

https://www.mathworks.com/help/optim/ug/linear-programming-with-equalities-and-inequalities.html

linprog(c,-eye(size(A,2)),zeros(size(A,2),1),A,b)

Use this command can get the result from linprog
